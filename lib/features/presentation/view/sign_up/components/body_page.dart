part of '../sign_up_layout.dart';

class _BodyPage extends StatefulWidget {
  const _BodyPage();

  @override
  State<_BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<_BodyPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Let's Start!",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.rF,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40.rH,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            decoration: BoxDecoration(color: MyColours.onSecondary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Username or email',
                        style: TextStyle(
                          color: MyColours.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.rH,
                    ),
                    CustomTextForm(
                      boxFillColor: MyColours.white,
                      border: 15,
                      controller: emailController,
                      validate: (val) => emailVlaidation(val!),
                    ),
                    SizedBox(
                      height: 20.rH,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Mobile Number',
                        style: TextStyle(
                          color: MyColours.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.rH,
                    ),
                    CustomTextForm(
                      hinText: 'Phone Number',
                      boxFillColor: MyColours.white,
                      keyBoardType: TextInputType.numberWithOptions(),
                      border: 15,
                      validate: (val) {
                        if (val!.isEmpty) {
                          return 'please enter your phone number';
                        } else {
                          return null;
                        }
                      },
                      controller: phoneController,
                    ),
                    SizedBox(
                      height: 20.rH,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: MyColours.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.rH,
                    ),
                    PasswordTextForm(
                      boxFillColor: MyColours.white,
                      border: 15,
                      controller: passwordController,
                      validate: (val) => passwordVlaidation(val!),
                    ),
                    SizedBox(
                      height: 20.rH,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(
                          color: MyColours.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.rH,
                    ),
                    PasswordTextForm(
                      boxFillColor: MyColours.white,
                      border: 15,
                      validate: (val) => confirmPasswordVlaidation(
                          val!, passwordController.text),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.rH,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.rH,
          ),
          Text('By continuing. you agree to',
              style: TextStyle(color: MyColours.white)),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Terms of Use",
                style: TextStyle(color: MyColours.onTerniary)),
            TextSpan(text: ' '),
            TextSpan(text: "and", style: TextStyle(color: MyColours.white)),
            TextSpan(text: ' '),
            TextSpan(
                text: 'Privacy Policy.',
                style: TextStyle(color: MyColours.onTerniary))
          ])),
          SizedBox(
            height: 20.rH,
          ),
          SignUpProvider(
            builder: (bloc, state) => CustomButton(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  log('validate');
                  bloc.add(SignUpEmailAndPasswordEvent(
                      emailController.text, passwordController.text));
                }
              },
              isSadow: false,
              radius: 50,
              borderColour: MyColours.white,
              backgroundColor: Color(0xff373737),
              width: SizeConfig.screenWidth * 0.4,
              listOfWidget: [
                Text('Sign Up',
                    style: TextStyle(
                      color: MyColours.white,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 20.rH,
          ),
          InkWell(
            onTap: () {
              back;
            },
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Already have an account?",
                  style: TextStyle(color: MyColours.white)),
              TextSpan(text: ' '),
              TextSpan(
                  text: 'Login', style: TextStyle(color: MyColours.onTerniary))
            ])),
          ),
          SizedBox(
            height: 20.rH,
          ),
          const SignUpListner(),
        ],
      ),
    );
  }
}

String? emailVlaidation(String email) {
  if (email.isNotEmpty) {
    if (email.contains('@') && email.contains('.com')) {
      return null;
    } else {
      return 'Please enter a valid email address ';
    }
  } else {
    return 'Please enter your email';
  }
}

String? passwordVlaidation(String password) {
  if (password.isNotEmpty) {
    if (password.length >= 8) {
      return null;
    } else {
      return 'The password entered is too short';
    }
  } else {
    return 'Please enter your password';
  }
}

String? confirmPasswordVlaidation(String password, String confirmPassword) {
  if (confirmPassword.isNotEmpty) {
    if (confirmPassword == password) {
      return null;
    } else {
      return 'The passwords do not match';
    }
  } else {
    return 'Please confirm your password';
  }
}
