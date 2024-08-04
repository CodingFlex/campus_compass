// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'sign_up_viewmodel.dart';

const bool _autoTextFieldValidation = true;

const String FullNameValueKey = 'fullName';
const String LevelValueKey = 'level';
const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';
const String ConfirmPasswordValueKey = 'confirmPassword';

final Map<String, TextEditingController> _SignUpPageTextEditingControllers = {};

final Map<String, FocusNode> _SignUpPageFocusNodes = {};

final Map<String, String? Function(String?)?> _SignUpPageTextValidations = {
  FullNameValueKey: SignUpFormValidation.validateFullName,
  LevelValueKey: SignUpFormValidation.validateLevel,
  EmailValueKey: SignUpFormValidation.validateEmail,
  PasswordValueKey: SignUpFormValidation.validatePassword,
  ConfirmPasswordValueKey: null,
};

mixin $SignUpPage {
  TextEditingController get fullNameController =>
      _getFormTextEditingController(FullNameValueKey);
  TextEditingController get levelController =>
      _getFormTextEditingController(LevelValueKey);
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  TextEditingController get passwordController =>
      _getFormTextEditingController(PasswordValueKey);
  TextEditingController get confirmPasswordController =>
      _getFormTextEditingController(ConfirmPasswordValueKey);

  FocusNode get fullNameFocusNode => _getFormFocusNode(FullNameValueKey);
  FocusNode get levelFocusNode => _getFormFocusNode(LevelValueKey);
  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);
  FocusNode get confirmPasswordFocusNode =>
      _getFormFocusNode(ConfirmPasswordValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_SignUpPageTextEditingControllers.containsKey(key)) {
      return _SignUpPageTextEditingControllers[key]!;
    }

    _SignUpPageTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _SignUpPageTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_SignUpPageFocusNodes.containsKey(key)) {
      return _SignUpPageFocusNodes[key]!;
    }
    _SignUpPageFocusNodes[key] = FocusNode();
    return _SignUpPageFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    fullNameController.addListener(() => _updateFormData(model));
    levelController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    confirmPasswordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    fullNameController.addListener(() => _updateFormData(model));
    levelController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    confirmPasswordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          FullNameValueKey: fullNameController.text,
          LevelValueKey: levelController.text,
          EmailValueKey: emailController.text,
          PasswordValueKey: passwordController.text,
          ConfirmPasswordValueKey: confirmPasswordController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _SignUpPageTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _SignUpPageFocusNodes.values) {
      focusNode.dispose();
    }

    _SignUpPageTextEditingControllers.clear();
    _SignUpPageFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get fullNameValue => this.formValueMap[FullNameValueKey] as String?;
  String? get levelValue => this.formValueMap[LevelValueKey] as String?;
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;
  String? get confirmPasswordValue =>
      this.formValueMap[ConfirmPasswordValueKey] as String?;

  set FullNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({FullNameValueKey: value}),
    );

    if (_SignUpPageTextEditingControllers.containsKey(FullNameValueKey)) {
      _SignUpPageTextEditingControllers[FullNameValueKey]?.text = value ?? '';
    }
  }

  set LevelValue(String? value) {
    this.setData(
      this.formValueMap..addAll({LevelValueKey: value}),
    );

    if (_SignUpPageTextEditingControllers.containsKey(LevelValueKey)) {
      _SignUpPageTextEditingControllers[LevelValueKey]?.text = value ?? '';
    }
  }

  set EmailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailValueKey: value}),
    );

    if (_SignUpPageTextEditingControllers.containsKey(EmailValueKey)) {
      _SignUpPageTextEditingControllers[EmailValueKey]?.text = value ?? '';
    }
  }

  set passwordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PasswordValueKey: value}),
    );

    if (_SignUpPageTextEditingControllers.containsKey(PasswordValueKey)) {
      _SignUpPageTextEditingControllers[PasswordValueKey]?.text = value ?? '';
    }
  }

  set confirmPasswordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ConfirmPasswordValueKey: value}),
    );

    if (_SignUpPageTextEditingControllers.containsKey(
        ConfirmPasswordValueKey)) {
      _SignUpPageTextEditingControllers[ConfirmPasswordValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasFullName =>
      this.formValueMap.containsKey(FullNameValueKey) &&
      (fullNameValue?.isNotEmpty ?? false);
  bool get hasLevel =>
      this.formValueMap.containsKey(LevelValueKey) &&
      (levelValue?.isNotEmpty ?? false);
  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);
  bool get hasPassword =>
      this.formValueMap.containsKey(PasswordValueKey) &&
      (passwordValue?.isNotEmpty ?? false);
  bool get hasConfirmPassword =>
      this.formValueMap.containsKey(ConfirmPasswordValueKey) &&
      (confirmPasswordValue?.isNotEmpty ?? false);

  bool get hasFullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey]?.isNotEmpty ?? false;
  bool get hasLevelValidationMessage =>
      this.fieldsValidationMessages[LevelValueKey]?.isNotEmpty ?? false;
  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;
  bool get hasConfirmPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey]?.isNotEmpty ??
      false;

  String? get FullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey];
  String? get LevelValidationMessage =>
      this.fieldsValidationMessages[LevelValueKey];
  String? get EmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
  String? get confirmPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey];
}

extension Methods on FormStateHelper {
  setFullNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FullNameValueKey] = validationMessage;
  setLevelValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[LevelValueKey] = validationMessage;
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;
  setConfirmPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    FullNameValue = '';
    LevelValue = '';
    EmailValue = '';
    passwordValue = '';
    confirmPasswordValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      LevelValueKey: getValidationMessage(LevelValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ConfirmPasswordValueKey: getValidationMessage(ConfirmPasswordValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _SignUpPageTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _SignUpPageTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      LevelValueKey: getValidationMessage(LevelValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ConfirmPasswordValueKey: getValidationMessage(ConfirmPasswordValueKey),
    });
