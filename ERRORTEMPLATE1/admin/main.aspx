<%@ Page Title="Contoso University - Main Menu" Language="C#" MasterPageFile="~/monday.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="ERRORTEMPLATE1.main" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="well">
            <h3>Departments</h3>
            <ul class="list-group">
                <li class="list-group-item"><a href="departments.aspx"></a> Departments</li>
                <li class="list-group-item"><a href="department.aspx"></a> Add Departments</li>
            </ul>
        </div>

        <div class="well">
            <h3>Courses</h3>
            <ul class="list-group">
                <li class="list-group-item"><a href="courses.aspx"></a> List Courses</li>
                <li class="list-group-item"><a href="course.aspx"></a> Add Course</li>
            </ul>
        </div>

        <div class="well">
            <h3>Students</h3>
            <ul class="list-group">
                <li class="list-group-item"><a href="students.aspx"></a> List Student</li>
                <li class="list-group-item"><a href="student.aspx"></a> Add Student</li>
            </ul>
        </div>

    </div>

</asp:Content>
