Public Class LoginForm1

   Private Sub OK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OK.Click
      Oracle.UserName = UsernameTextBox.Text
      Oracle.PassWd = PasswordTextBox.Text
      Oracle.Server = TextBox1.Text

      Oracle.Result = Oracle.ResponseType.OK

      Me.Close()
   End Sub

   Private Sub Cancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Cancel.Click
      Oracle.Result = Oracle.ResponseType.Cancel

      Me.Close()
   End Sub

   Private Sub FormClassLogin_Load(sender As Object, e As EventArgs) Handles MyBase.Load

   End Sub
End Class

