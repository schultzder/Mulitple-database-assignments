Public Class FormClassBooking
   Private dgvBooking As Object
   Private cobField As Object
   Private cobOp As Object
   Private txtValue As Object

   Private Sub FormClassBooking_Load(sender As Object, e As EventArgs) Handles MyBase.Load
      ' Binding it to myTable
      dgvBooking.DataSource = Oracle.myTable

   End Sub

   Private Sub Button2_Click(sender As Object, e As EventArgs)

      Dim field As String = cobField.Text
      Dim op As String = cobOp.Text
      Dim value As String = txtValue.Text

      If field = "Date_From" Or field = "Date_To" Then
         Try
            Dim theDate As Date = value

            Oracle.bookingCommand.CommandText =
                       "Select * " &
                       "From Booking " &
                       "Where " & field & op & "to_Date('" & theDate & "', 'mm/dd/yyyy')"
         Catch ex As Exception
            MessageBox.Show(ex.Message)
         End Try
      Else
         ' For string values
         Oracle.bookingCommand.CommandText =
                       "Select * " &
                       "From Booking " &
                       "Where " & field & op & " '" & value & "'"
      End If

      ' Check CommandText 
      MessageBox.Show(Oracle.bookingCommand.CommandText)

      ' Catch exception
      Try
         Oracle.myTable.Clear()
         Oracle.bookingAdapter.Fill(Oracle.myTable)
      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try

   End Sub

   Private Sub Button3_Click(sender As Object, e As EventArgs)
      Oracle.bookingCommand.CommandText = "Select * from booking"

      Try
         Oracle.myTable.Clear()
         Oracle.bookingAdapter.Fill(Oracle.myTable)
      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try

   End Sub

   Private Sub Button1_Click(sender As Object, e As EventArgs)
      Try
         Me.BindingContext(Oracle.myTable).EndCurrentEdit()
         Oracle.bookingAdapter.Update(Oracle.myTable)
      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try

   End Sub

   Private Sub TextBox8_TextChanged(sender As Object, e As EventArgs) Handles TextBox8.TextChanged

   End Sub

   Private Sub Button1_Click_1(sender As Object, e As EventArgs) Handles Button1.Click

   End Sub

   Private Sub Label3_Click(sender As Object, e As EventArgs) Handles Label3.Click

   End Sub

   Private Sub Label4_Click(sender As Object, e As EventArgs) Handles Label4.Click

   End Sub

   Private Sub Label28_Click(sender As Object, e As EventArgs) Handles Label28.Click

   End Sub

   Private Sub Button12_Click(sender As Object, e As EventArgs) Handles Button12.Click
      Application.Exit()
   End Sub

   Private Sub TextBox24_TextChanged(sender As Object, e As EventArgs) Handles TextBox24.TextChanged

   End Sub
End Class
