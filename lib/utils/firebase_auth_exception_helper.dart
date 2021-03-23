class FirebaseAuthExceptionHelper {
  static String message(String code) {
    switch (code) {
      case 'invalid-email': return 'メールアドレスが間違っています。';
      case 'wrong-password': return 'パスワードが間違っています。';
      case 'user-not-found': return 'このアカウントは存在しません。';
      case 'user-disabled': return 'このメールアドレスは無効になっています。';
      case 'too-many-requests': return '回線が混雑しています。もう一度試してみてください。';
      case 'operation-not-allowed': return 'メールアドレスとパスワードでのログインは有効になっていません。';
      case 'email-already-in-use': return 'このメールアドレスはすでに登録されています。';
      default: return '予期せぬエラーが発生しました。';
    }
  }
}
