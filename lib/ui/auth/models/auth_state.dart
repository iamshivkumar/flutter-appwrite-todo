

class AuthState {
  final String email;
  final String password;
  final bool loading;
  final bool obscureText;
  final String name;
  
  AuthState({
     this.email = "",
     this.password = "",
     this.loading = false,
     this.obscureText = true,
     this.name = "",
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? loading,
    bool? obscureText,
    String? name,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      loading: loading ?? this.loading,
      obscureText: obscureText ?? this.obscureText,
      name: name ?? this.name,
    );
  }
}
