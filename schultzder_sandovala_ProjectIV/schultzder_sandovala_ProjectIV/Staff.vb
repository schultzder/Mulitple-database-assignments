Public Class Staff
   Private UWP_Staff_Binding As New BindingSource
   Private UWP_Work_Binding As New BindingSource
   Private UWP_Qual_Binding As New BindingSource
   Private workDataView As New DataView()
   Private qualDataView As New DataView()

   Private Sub FormClassStaff_Load(sender As Object, e As EventArgs) Handles MyBase.Load
      Try
         UWP_Staff_Binding.DataSource = Oracle.staffTable

         TextBoxSTAFFNO.DataBindings.Add("Text", UWP_Staff_Binding, "staffNo")
         TextBoxFNAME.DataBindings.Add("Text", UWP_Staff_Binding, "fName")
         TextBoxLNAME.DataBindings.Add("Text", UWP_Staff_Binding, "lName")
         TextBoxSTREET.DataBindings.Add("Text", UWP_Staff_Binding, "street")
         TextBoxCITY.DataBindings.Add("Text", UWP_Staff_Binding, "city")
         TextBoxSTATE.DataBindings.Add("Text", UWP_Staff_Binding, "state")
         TextBoxZIP.DataBindings.Add("Text", UWP_Staff_Binding, "zip")
         TextBoxPHONE.DataBindings.Add("Text", UWP_Staff_Binding, "phone")
         ComboBoxDOB.DataBindings.Add("Text", UWP_Staff_Binding, "DOB")
         TextBoxGENDER.DataBindings.Add("Text", UWP_Staff_Binding, "gender")
         TextBoxNIN.DataBindings.Add("Text", UWP_Staff_Binding, "NIN")
         TextBoxPOSITION.DataBindings.Add("Text", UWP_Staff_Binding, "position")
         TextBoxCURSALARY.DataBindings.Add("Text", UWP_Staff_Binding, "curSalary")
         TextBoxSALARYSCALE.DataBindings.Add("Text", UWP_Staff_Binding, "salaryScale")
         TextBoxHRSPERWK.DataBindings.Add("Text", UWP_Staff_Binding, "hrsPerWk")
         TextBoxPOSPERMTEMP.DataBindings.Add("Text", UWP_Staff_Binding, "posPermTemp")
         TextBoxTYPEOFPAY.DataBindings.Add("Text", UWP_Staff_Binding, "typeOfPay")


         workDataView.Table = Oracle.workTable
         UWP_Work_Binding.DataSource = workDataView

         TextBoxORGNAME.DataBindings.Add("Text", UWP_Work_Binding, "orgName")
         TextBoxWORKPOS.DataBindings.Add("Text", UWP_Work_Binding, "position")
         TextBoxSTARTDATE.DataBindings.Add("Text", UWP_Work_Binding, "startDate")
         TextBoxFINISHDATE.DataBindings.Add("Text", UWP_Work_Binding, "finishDate")


         qualDataView.Table = Oracle.qualTable
         UWP_Qual_Binding.DataSource = qualDataView

         ComboBoxQUALDATE.DataBindings.Add("Text", UWP_Qual_Binding, "qualDate")
         TextBoxTYPE.DataBindings.Add("Text", UWP_Qual_Binding, "type")
         TextBoxINSTNAME.DataBindings.Add("Text", UWP_Qual_Binding, "instName")
         UpdateFields()

      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try

   End Sub

   Private Sub Button24_Click(sender As Object, e As EventArgs) Handles Button24.Click
      Application.Exit()
   End Sub

   Private Sub UpdateFields()
      workDataView.RowFilter = "staffNo = '" & TextBoxSTAFFNO.Text & "'"
      qualDataView.RowFilter = "staffNo = '" & TextBoxSTAFFNO.Text & "'"
      TextBoxSTAFFcount.Text = (UWP_Staff_Binding.Position + 1) & "/" & UWP_Staff_Binding.Count
      TextBoxQUALcount.Text = (UWP_Qual_Binding.Position + 1) & "/" & UWP_Qual_Binding.Count
      TextBoxWORKcount.Text = (UWP_Work_Binding.Position + 1) & "/" & UWP_Work_Binding.Count

#Region "Staff Buttons Enabled"

      If UWP_Staff_Binding.Position = 0 Then
         ButtonStaffJumpB.Enabled = False
         ButtonPrevStaff.Enabled = False
      End If

      If UWP_Staff_Binding.Position + 1 < UWP_Staff_Binding.Count Then
         ButtonNextStaff.Enabled = True
         ButtonStaffJumpF.Enabled = True
      End If

      If UWP_Staff_Binding.Position + 1 = UWP_Staff_Binding.Count Then
         ButtonStaffJumpF.Enabled = False
         ButtonNextStaff.Enabled = False
      End If

      If UWP_Staff_Binding.Position > 0 Then
         ButtonPrevStaff.Enabled = True
         ButtonStaffJumpB.Enabled = True
      End If

#End Region


      '-------------------------------------------------------------------------

#Region "Qual Buttons Enabled"
      If UWP_Qual_Binding.Position = 0 Then
         ButtonQualJumpFirst.Enabled = False
         ButtonQualPrev.Enabled = False
      End If

      If UWP_Qual_Binding.Position + 1 < UWP_Qual_Binding.Count Then
         ButtonQualNext.Enabled = True
         ButtonQualJumpLast.Enabled = True
      End If

      If UWP_Qual_Binding.Position + 1 = UWP_Qual_Binding.Count Then
         ButtonQualJumpLast.Enabled = False
         ButtonQualNext.Enabled = False
      End If

      If UWP_Qual_Binding.Position > 0 Then
         ButtonQualPrev.Enabled = True
         ButtonQualJumpFirst.Enabled = True
      End If

#End Region

      '--------------------------------------------------------------------------

#Region "Work Buttons Enabled"
      If UWP_Work_Binding.Position = 0 Then
         ButtonWorkJumpFirst.Enabled = False
         ButtonWorkPrev.Enabled = False
      End If

      If UWP_Work_Binding.Position + 1 < UWP_Work_Binding.Count Then
         ButtonWorkNext.Enabled = True
         ButtonWorkJumpLast.Enabled = True
      End If

      If UWP_Work_Binding.Position + 1 = UWP_Work_Binding.Count Then
         ButtonWorkJumpLast.Enabled = False
         ButtonWorkNext.Enabled = False
      End If

      If UWP_Work_Binding.Position > 0 Then
         ButtonWorkPrev.Enabled = True
         ButtonWorkJumpFirst.Enabled = True
      End If
#End Region


   End Sub




#Region "Staff"
   Private Sub ButtonNextStaff_Click(sender As Object, e As EventArgs) Handles ButtonNextStaff.Click
      UWP_Staff_Binding.MoveNext()
      UWP_Qual_Binding.MoveNext()
      UWP_Work_Binding.MoveNext()
      UpdateFields()



   End Sub

   Private Sub ButtonPrevStaff_Click(sender As Object, e As EventArgs) Handles ButtonPrevStaff.Click
      UWP_Staff_Binding.MovePrevious()
      UWP_Qual_Binding.MovePrevious()
      UWP_Work_Binding.MovePrevious()
      UpdateFields()

   End Sub

   Private Sub TextBoxSTAFFcount_TextChanged(sender As Object, e As EventArgs) Handles TextBoxSTAFFcount.TextChanged
      TextBoxSTAFFcount.Text = (UWP_Staff_Binding.Position + 1) & "/" & UWP_Staff_Binding.Count
   End Sub

   Private Sub ButtonStaffJumpF_Click(sender As Object, e As EventArgs) Handles ButtonStaffJumpF.Click
      UWP_Staff_Binding.MoveLast()
      UWP_Qual_Binding.MoveLast()
      UWP_Work_Binding.MoveLast()
      UpdateFields()


   End Sub

   Private Sub ButtonStaffJumpB_Click(sender As Object, e As EventArgs) Handles ButtonStaffJumpB.Click
      UWP_Staff_Binding.MoveFirst()
      UWP_Qual_Binding.MoveFirst()
      UWP_Work_Binding.MoveFirst()
      UpdateFields()

   End Sub

   Private Sub DisableAllButtons()
      ButtonNEWWork.Enabled = False
      ButtonSAVEwork.Enabled = False
      ButtonDELETEwork.Enabled = False
      ButtonALL.Enabled = False
      ButtonSEARCH.Enabled = False
      ButtonNEWQual.Enabled = False
      ButtonSAVEQual.Enabled = False
      ButtonDELETEQual.Enabled = False
   End Sub

   Private Sub EnableAllButtons()
      ButtonNEWWork.Enabled = True
      ButtonSAVEwork.Enabled = True
      ButtonDELETEwork.Enabled = True
      ButtonALL.Enabled = True
      ButtonSEARCH.Enabled = True
      ButtonNEWQual.Enabled = True
      ButtonSAVEQual.Enabled = True
      ButtonDELETEQual.Enabled = True
   End Sub

   Private Sub ButtonNEWStaff_Click(sender As Object, e As EventArgs) Handles ButtonNEWStaff.Click
      Dim r As DataRowView
      r = UWP_Staff_Binding.AddNew
      ' The new row is added at the end

      UWP_Staff_Binding.MoveLast()
      TextBoxSTAFFcount.Text = (UWP_Staff_Binding.Position + 1) & "/" & UWP_Staff_Binding.Count
      DisableAllButtons()


   End Sub

   Private Sub ButtonDELETEStaff_Click(sender As Object, e As EventArgs) Handles ButtonDELETEStaff.Click
      Try
         UWP_Staff_Binding.RemoveCurrent()
      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try
   End Sub

   Private Sub ButtonSAVEStaff_Click(sender As Object, e As EventArgs) Handles ButtonSAVEStaff.Click
      Try
         UWP_Staff_Binding.EndEdit()
         Oracle.staffAdapter.Update(Oracle.staffTable)
      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try

      EnableAllButtons()
   End Sub

#End Region

#Region "Work Experince"

   Private Sub ButtonWorkNext_Click(sender As Object, e As EventArgs) Handles ButtonWorkNext.Click
      UWP_Work_Binding.MoveNext()
      UpdateFields()
   End Sub
   Private Sub ButtonWorkPrev_Click(sender As Object, e As EventArgs) Handles ButtonWorkPrev.Click
      UWP_Work_Binding.MovePrevious()
      UpdateFields()
   End Sub

   Private Sub ButtonWorkJumpLast_Click(sender As Object, e As EventArgs) Handles ButtonWorkJumpLast.Click
      UWP_Work_Binding.MoveLast()
      UpdateFields()
   End Sub

   Private Sub ButtonWorkJumpFirst_Click(sender As Object, e As EventArgs) Handles ButtonWorkJumpFirst.Click
      UWP_Work_Binding.MoveFirst()
      UpdateFields()
   End Sub

   Private Sub TextBoxWORKcount_TextChanged(sender As Object, e As EventArgs) Handles TextBoxWORKcount.TextChanged
      TextBoxWORKcount.Text = (UWP_Work_Binding.Position + 1) & "/" & UWP_Work_Binding.Count
   End Sub

   Private Sub ButtonNEWWork_Click(sender As Object, e As EventArgs) Handles ButtonNEWWork.Click
      Dim r As DataRowView
      r = UWP_Work_Binding.AddNew
      ' The new row is added at the end
      UWP_Work_Binding.MoveLast()
   End Sub

   Private Sub ButtonSAVEwork_Click(sender As Object, e As EventArgs) Handles ButtonSAVEwork.Click
      Try
         UWP_Work_Binding.EndEdit()
         Oracle.workAdapter.Update(Oracle.workTable)
      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try
   End Sub

   Private Sub ButtonDELETEwork_Click(sender As Object, e As EventArgs) Handles ButtonDELETEwork.Click
      Try
         UWP_Work_Binding.RemoveCurrent()
      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try
   End Sub

#End Region

#Region "Qualifications"

   Private Sub ButtonQualNext_Click(sender As Object, e As EventArgs) Handles ButtonQualNext.Click
      UWP_Qual_Binding.MoveNext()
      UpdateFields()
   End Sub

   Private Sub ButtonQualPrev_Click(sender As Object, e As EventArgs) Handles ButtonQualPrev.Click
      UWP_Qual_Binding.MovePrevious()
      UpdateFields()
   End Sub

   Private Sub ButtonQualJumpLast_Click(sender As Object, e As EventArgs) Handles ButtonQualJumpLast.Click
      UWP_Qual_Binding.MoveLast()
      UpdateFields()
   End Sub

   Private Sub ButtonQualJumpFirst_Click(sender As Object, e As EventArgs) Handles ButtonQualJumpFirst.Click
      UWP_Qual_Binding.MoveFirst()
      UpdateFields()
   End Sub
   Private Sub TextBoxQUALcount_TextChanged(sender As Object, e As EventArgs) Handles TextBoxQUALcount.TextChanged
      TextBoxQUALcount.Text = (UWP_Qual_Binding.Position + 1) & "/" & UWP_Qual_Binding.Count
   End Sub

   Private Sub ButtonNEWQual_Click(sender As Object, e As EventArgs) Handles ButtonNEWQual.Click
      Dim r As DataRowView
      r = UWP_Qual_Binding.AddNew
      ' The new row is added at the end
      UWP_Qual_Binding.MoveLast()
   End Sub

   Private Sub ButtonSAVEQual_Click(sender As Object, e As EventArgs) Handles ButtonSAVEQual.Click
      Try
         UWP_Qual_Binding.EndEdit()
         Oracle.qualAdapter.Update(Oracle.qualTable)
      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try
   End Sub

   Private Sub ButtonDELETEQual_Click(sender As Object, e As EventArgs) Handles ButtonDELETEQual.Click
      Try
         UWP_Qual_Binding.RemoveCurrent()
      Catch ex As Exception
         MessageBox.Show(ex.Message)
      End Try
   End Sub
#End Region

   Private Sub ButtonSEARCH_Click(sender As Object, e As EventArgs) Handles ButtonSEARCH.Click

      If ComboBoxFIELD.Text = "TYPE" Then
         Oracle.qualCommand.CommandText = "Select * from UWP_Qualifications" &
                        "Where Name = '" & TextBoxVALUE.Text & "'"

         Oracle.qualTable.Clear()
         Oracle.qualAdapter.Fill(Oracle.qualTable)
         UpdateFields()

      End If

      If ComboBoxFIELD.Text = "ORGNAME" Then
         Oracle.workCommand.CommandText = "Select * from UWP_WorkExperience" &
                             "Where Name = '" & TextBoxVALUE.Text & "'"

         Oracle.workTable.Clear()
         Oracle.workAdapter.Fill(Oracle.workTable)
         UpdateFields()
      End If

   End Sub

   Private Sub ComboBoxFIELD_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ComboBoxFIELD.SelectedIndexChanged
      ComboBoxFIELD.Items.Clear()
      ComboBoxFIELD.Items.Add("TYPE")
      ComboBoxFIELD.Items.Add("ORGNAME")

   End Sub

   Private Sub ButtonALL_Click(sender As Object, e As EventArgs) Handles ButtonALL.Click
      Oracle.staffCommand.CommandText = "Select * from UWP_Staff "
      Oracle.qualCommand.CommandText = "Select * from UWP_Qualifications"
      Oracle.workCommand.CommandText = "Select * from UWP_WorkExperience"

      Oracle.staffTable.Clear()
      Oracle.qualTable.Clear()
      Oracle.workTable.Clear()
      Oracle.staffAdapter.Fill(Oracle.staffTable)
      Oracle.qualAdapter.Fill(Oracle.qualTable)
      Oracle.workAdapter.Fill(Oracle.workTable)
      UpdateFields()
   End Sub
End Class