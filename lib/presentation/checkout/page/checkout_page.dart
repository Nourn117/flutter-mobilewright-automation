import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/di/injection.dart';
import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/utils/format.dart';
import 'package:mobilewright_demo_app/core/utils/validators.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/checkout_details.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/pricing.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_cubit.dart';
import 'package:mobilewright_demo_app/presentation/checkout/cubit/checkout_cubit.dart';
import 'package:mobilewright_demo_app/presentation/checkout/cubit/checkout_state.dart';
import 'package:mobilewright_demo_app/presentation/checkout/widgets/option_tile.dart';
import 'package:mobilewright_demo_app/presentation/checkout/widgets/section_card.dart';
import 'package:mobilewright_demo_app/presentation/common/cubit/session_cubit.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/error_banner.dart';
import 'package:mobilewright_demo_app/presentation/common/widgets/summary_row.dart';
import 'package:mobilewright_demo_app/presentation/order_success/page/order_success_page.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CheckoutCubit>(),
      child: const _CheckoutView(),
    );
  }
}

class _CheckoutView extends StatefulWidget {
  const _CheckoutView();

  @override
  State<_CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<_CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _notes = TextEditingController();

  String? _city;
  DateTime? _date;
  DeliverySlot _slot = DeliverySlot.morning;
  PaymentMethod _payment = PaymentMethod.cashOnDelivery;
  bool _saveAddress = false;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(
      text: context.read<SessionCubit>().state?.name ?? '',
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDate() {
    final tomorrow = DateUtils.dateOnly(DateTime.now()).add(
      const Duration(days: 1),
    );
    return showDatePicker(
      context: context,
      initialDate: _date ?? tomorrow,
      firstDate: tomorrow,
      lastDate: tomorrow.add(const Duration(days: 13)),
      helpText: 'Select delivery date',
    );
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    context.read<CheckoutCubit>().placeOrder(CheckoutDetails(
          fullName: _name.text.trim(),
          phone: _phone.text.trim(),
          city: _city!,
          address: _address.text.trim(),
          deliveryDate: _date!,
          slot: _slot,
          paymentMethod: _payment,
          saveAddress: _saveAddress,
          notes: _notes.text.trim(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartCubit>().state;

    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listenWhen: (prev, curr) => prev != curr,
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          context.read<CartCubit>().refresh();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (_) => OrderSuccessPage(order: state.order),
            ),
          );
        }
      },
      builder: (context, state) {
        final submitting = state is CheckoutSubmitting;
        return Scaffold(
          appBar: AppBar(title: const Text('Checkout')),
          body: Form(
            key: _formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(16),
              children: [
                SectionCard(
                  title: 'Contact details',
                  icon: Icons.person_outline_rounded,
                  children: [
                    TestId(
                      TestIds.checkoutName,
                      child: TextFormField(
                        controller: _name,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: 'Full name'),
                        validator: Validators.name,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TestId(
                      TestIds.checkoutPhone,
                      child: TextFormField(
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        maxLength: 11,
                        decoration: const InputDecoration(
                          labelText: 'Mobile number',
                          hintText: '01XXXXXXXXX',
                          counterText: '',
                        ),
                        validator: Validators.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Delivery',
                  icon: Icons.local_shipping_outlined,
                  children: [
                    TestId(
                      TestIds.checkoutCity,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'City'),
                        items: [
                          for (final c in Pricing.cities)
                            DropdownMenuItem(value: c, child: Text(c)),
                        ],
                        onChanged: (v) => setState(() => _city = v),
                        validator: (v) =>
                            v == null ? 'Please select a city' : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TestId(
                      TestIds.checkoutAddress,
                      child: TextFormField(
                        controller: _address,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Street address',
                          hintText: 'Building, street, area',
                        ),
                        validator: Validators.address,
                      ),
                    ),
                    const SizedBox(height: 12),
                    FormField<DateTime>(
                      validator: (_) => _date == null
                          ? 'Please select a delivery date'
                          : null,
                      builder: (field) => TestId(
                        TestIds.checkoutDate,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () async {
                            final picked = await _pickDate();
                            if (picked == null || !mounted) return;
                            setState(() => _date = picked);
                            field.didChange(picked);
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Delivery date',
                              errorText: field.errorText,
                              suffixIcon:
                                  const Icon(Icons.calendar_month_outlined),
                            ),
                            child: Text(_date == null
                                ? 'Select a date'
                                : formatDate(_date!)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Time slot',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<DeliverySlot>(
                        segments: const [
                          ButtonSegment(
                            value: DeliverySlot.morning,
                            icon: Icon(Icons.wb_sunny_outlined),
                            label: TestId(TestIds.checkoutSlotMorning,
                                child: Text('9 AM - 1 PM')),
                          ),
                          ButtonSegment(
                            value: DeliverySlot.evening,
                            icon: Icon(Icons.nights_stay_outlined),
                            label: TestId(TestIds.checkoutSlotEvening,
                                child: Text('5 PM - 9 PM')),
                          ),
                        ],
                        selected: {_slot},
                        onSelectionChanged: (s) =>
                            setState(() => _slot = s.first),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Payment',
                  icon: Icons.payments_outlined,
                  children: [
                    OptionTile(
                      id: TestIds.checkoutPaymentCash,
                      icon: Icons.money_rounded,
                      title: 'Cash on delivery',
                      subtitle: 'Pay when your order arrives',
                      selected: _payment == PaymentMethod.cashOnDelivery,
                      onTap: () => setState(
                          () => _payment = PaymentMethod.cashOnDelivery),
                    ),
                    const SizedBox(height: 10),
                    OptionTile(
                      id: TestIds.checkoutPaymentCard,
                      icon: Icons.credit_card_rounded,
                      title: 'Card on delivery',
                      subtitle: 'Pay by card to the courier',
                      selected: _payment == PaymentMethod.card,
                      onTap: () =>
                          setState(() => _payment = PaymentMethod.card),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Extras',
                  icon: Icons.tune_rounded,
                  children: [
                    TestId(
                      TestIds.checkoutNotes,
                      child: TextFormField(
                        controller: _notes,
                        maxLines: 2,
                        maxLength: 120,
                        decoration: const InputDecoration(
                          labelText: 'Delivery notes (optional)',
                        ),
                      ),
                    ),
                    TestId(
                      TestIds.checkoutSaveAddress,
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('Save this address for next time'),
                        value: _saveAddress,
                        onChanged: (v) =>
                            setState(() => _saveAddress = v ?? false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Order summary',
                  icon: Icons.receipt_long_outlined,
                  children: [
                    SummaryRow(
                      label: 'Subtotal (${cart.count} items)',
                      value: formatPrice(cart.subtotal),
                    ),
                    SummaryRow(
                      label: 'Delivery',
                      value: formatPrice(cart.deliveryFee),
                    ),
                    const Divider(height: 20),
                    SummaryRow(
                      label: 'Total',
                      value: formatPrice(cart.total),
                      valueId: TestIds.checkoutTotal,
                      emphasized: true,
                    ),
                  ],
                ),
                if (state case CheckoutFailure(:final message)) ...[
                  const SizedBox(height: 16),
                  ErrorBanner(id: TestIds.checkoutError, message: message),
                ],
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: TestId(
                TestIds.checkoutPlaceOrder,
                child: FilledButton(
                  onPressed: submitting ? null : _submit,
                  child: submitting
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        )
                      : Text('Place order · ${formatPrice(cart.total)}'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
