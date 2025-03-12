import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:horas_v1/screens/register_screen.dart';
import 'package:horas_v1/screens/reset_password_modal.dart';
import 'package:horas_v1/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  FlutterLogo(size: 76),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                    )
                  ),
                  SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    controller: _senhaController,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                    )
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(onPressed: () {
                    authService.entrarUsuario(email: _emailController.text, senha: _senhaController.text).then((String? erro) {
                      if(erro != null){
                        final snackBar = SnackBar(content: Text(erro), backgroundColor: Colors.red);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }, child: Text('Entrar'),),
                  SizedBox(height: 16),
                  ElevatedButton(onPressed: () {
                    singinWithGoogle();
                  }, child: Text('Entrar com o Google'),),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/register');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                    },
                    child: Text('Ainda não é cadastrado, crie uma conta'),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(context: context, builder: (BuildContext context){
                        return PasswordResetModal();
                      });
                    },
                    child: Text('Esqueceu a senha?'),
                  ),
                ],
              ),
            )
          ],
        ),
      )
      )
    );
  }

  Future<UserCredential> singinWithGoogle() async{
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken
     );
     return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
