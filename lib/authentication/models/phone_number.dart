
enum EmailValidationError { invalid }

class PhoneNumber {
  const PhoneNumber.pure() ;
  const PhoneNumber.dirty([String value = '']) ;

  // static final RegExp _phoneNumberRegExp = RegExp(
  //   r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  // );
  //
  // @override
  // EmailValidationError validator(String value) {
  //   return _phoneNumberRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  // }
}
