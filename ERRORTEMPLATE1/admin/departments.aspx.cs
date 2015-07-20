using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//reference our entity framework models
using ERRORTEMPLATE1.Models;
using System.Web.ModelBinding;
using System.Linq.Dynamic;

namespace ERRORTEMPLATE1
{
    public partial class departments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //fill the grid
            if (!IsPostBack)
            {
                Session["SortDirection"] = "ASC";
                Session["SortColumn"] = "DepartmentID";
                GetDepartments();
            }
        }

        protected void GetDepartments()
        {
            try
            {
                //connect using our connection string from web.config and EF context class
                using (DefaultConnectionEF db = new DefaultConnectionEF())
                {
                    //use link to query the Departments model
                    var departments = (from d in db.Departments
                                       select new { d.DepartmentID, d.Name, d.Budget });

                    //var deps = from d in conn.Departments
                    //select d;

                    //append the current direction to the Sort Column
                    String Sort = Session["SortColumn"].ToString() + " " + Session["SortDirection"].ToString();

                    //bind the query result to the gridview
                    //grdDepartments.DataSource = departments.ToList();
                    grdDepartments.DataSource = departments.AsQueryable().OrderBy(Sort).ToList();
                    grdDepartments.DataBind();
                }
            }
            catch (System.IO.IOException)
            {
                Server.Transfer("/error.aspx", true);
            }
        }

        protected void grdDepartments_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                //connect
                using (DefaultConnectionEF conn = new DefaultConnectionEF())
                {
                    //get the selected DepartmentID
                    Int32 DepartmentID = Convert.ToInt32(grdDepartments.DataKeys[e.RowIndex].Values["DepartmentID"]);

                    var d = (from dep in conn.Departments
                             where dep.DepartmentID == DepartmentID
                             select dep).FirstOrDefault();

                    //process the delete
                    conn.Departments.Remove(d);
                    conn.SaveChanges();


                }
            }
            catch (System.IO.IOException)
            {
                Server.Transfer("/error.aspx", true);
            }
            //update the grid
            GetDepartments();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            //set the page size and refresh the grid
            grdDepartments.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            GetDepartments();
        }

        protected void grdDepartments_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //set the page index and refresh the grid
            grdDepartments.PageIndex = e.NewPageIndex;
            GetDepartments();
        }

        protected void grdDepartments_Sorting(object sender, GridViewSortEventArgs e)
        {
            //set the global sort column to column clicked on by the user
            Session["SortColumn"] = e.SortExpression;
            GetDepartments();

            //toggle the direction
            if (Session["SortDirection"].ToString() == "ASC")
            {
                Session["SortDirection"] = "DESC";
            }
            else
            {
                Session["SortDirection"] = "ASC";
            }
        }

        protected void grdDepartments_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (IsPostBack)
            {
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    Image SortImage = new Image();
                    //loop though each column
                    for (int i = 0; i <= grdDepartments.Columns.Count - 1; i++)
                    {
                        if (grdDepartments.Columns[i].SortExpression == Session["SortColumn"].ToString())
                        {
                            if (Session["SortDirection"].ToString() == "DESC")
                            {
                                SortImage.ImageUrl = "images/desc.jpg";
                                SortImage.AlternateText = "Sort Desending";
                            }
                            else
                            {
                                SortImage.ImageUrl = "images/asc.jpg";
                                SortImage.AlternateText = "Sort Assending";
                            }

                            e.Row.Cells[i].Controls.Add(SortImage);

                        }
                    }
                }
            }
        }
    }
}