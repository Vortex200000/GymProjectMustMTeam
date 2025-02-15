part of '../login_layout.dart';

class _BodyPage extends StatefulWidget {
  const _BodyPage();

  @override
  State<_BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<_BodyPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Welcome',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.rF,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.rH,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child: Text(
              'Consistency is the key to achieving fitness goals. Whether youre building muscle, losing weight, or improving endurance, staying committed to a structured workout routine is essential. Proper nutrition, adequate rest, and progressive training all play a crucial role in maximizing results. Push yourself, stay disciplined, and track your progress to stay motivated. Every workout brings you one step closer to your goals.Stay focused, trust the process, and become the best version of yourself.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.rF,
                  fontWeight: FontWeight.w400),
            ),
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
                  ],
                ),
                SizedBox(
                  height: 15.rH,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: MyColours.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.rH,
          ),
          SignInProvider(
            builder: (bloc, state) => CustomButton(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  bloc.add(SignInEmailAndPasswordEvent(
                      emailController.text, passwordController.text));
                }
              },
              isSadow: false,
              radius: 50,
              borderColour: MyColours.white,
              backgroundColor: Color(0xff373737),
              width: SizeConfig.screenWidth * 0.4,
              listOfWidget: [
                Text('Login',
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
              Get.toNamed(Routes.signUpRoute);
            },
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(color: MyColours.white)),
              TextSpan(text: ' '),
              TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(color: MyColours.onTerniary))
            ])),
          ),
          const SignInListner(),
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
