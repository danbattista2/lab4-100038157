<%@ Page Title="Course Details" Language="C#" MasterPageFile="~/monday.Master" AutoEventWireup="true" CodeBehind="course.aspx.cs" Inherits="ERRORTEMPLATE1.course" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h1>Course Details</h1>

        <div class="form-group">
            <label for="txtTitle" class="control-label col-sm-2">Title:</label>
            <asp:TextBox ID="txtTitle" runat="server" required MaxLength="100" />
        </div>
        <div class="form-group">
            <label for="txtCredits" class="control-label col-sm-2">Credits:</label>
            <asp:TextBox ID="txtCredits" runat="server" required TextMode="Number" />
        </div>
        <div class="form-group">
            <label for="ddlDepartment" class="control-label col-sm-2">Department:</label>
            <asp:DropDownList ID="ddlDepartment" runat="server" 
                 DataTextField="Name" DataValueField="DepartmentID"></asp:DropDownList>
        </div>
        <div class="col-sm-2 col-sm-offset-2">
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-primary" />
        </div>
    </div>

    <!--Does not show when addeding student-->
    <asp:Panel ID="pnlStudents" runat="server" Visible="false">
    <h2>Students</h2>
    <asp:GridView ID="grdStudents" runat="server" DataKeyNames="StudentID" AutoGenerateColumns="false" CssClass="table table-striped table-hover"
          OnRowDeleting="grdStudents_RowDeleting">
        <Columns>
            <asp:BoundField DataField="EnrollmentID" HeaderText="EnrollmentID" />
            <asp:BoundField DataField="StudentID" HeaderText="StudentID" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="FirstMidName" HeaderText="First Name" />
            <asp:BoundField DataField="EnrollmentDate" HeaderText="Enrollment Date" />
            <asp:CommandField ShowDeleteButton="true" HeaderText="Delete" DeleteText="Delete" />
        </Columns>
    </asp:GridView>

        <table class="table table-striped table-hover">
        <thead>
            <th>Student</th>
            <th>Course</th>
            <th>Add</th>
        </thead>
        <tbody>
            <tr>
                <td>
                    <asp:DropDownList ID="ddlStudent" runat="server" AutoPostBack="true"
                         DataValueField="StudentID" DataTextField="StudentID"
                         OnSelectedIndexChanged="ddlStudent_SelectedIndexChanged"></asp:DropDownList>
                    <asp:RangeValidator runat="server" ControlToValidate="ddlStudent"
                         Type="Integer" MinimumValue="1" MaximumValue="99999999"
                         ErrorMessage="Required" CssClass="label label-danger" />
                </td>
                <td>
                    <asp:DropDownList ID="ddlCourse" runat="server"
                         DataValueField="CourseID" DataTextField="Title"></asp:DropDownList>
                    <asp:RangeValidator runat="server" ControlToValidate="ddlCourse"
                         Type="Integer" MinimumValue="1" MaximumValue="99999999"
                         ErrorMessage="Required" CssClass="label label-danger" />
                </td>
            <td>
                <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary"
                     OnClick="btnAdd_Click"/>
            </td>
            </tr>   
         </tbody>  
         </table>
    </asp:Panel>

</asp:Content>
