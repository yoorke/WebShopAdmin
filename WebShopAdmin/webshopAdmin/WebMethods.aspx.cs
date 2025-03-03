using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using eshopBL;
using System.Web.Configuration;
using Newtonsoft.Json;
using System.Web.Services;
using eshopUtilities;
using eshop.Import.BL.Interfaces;
using eshop.Import.BL;

namespace webshopAdmin
{
    public partial class WebMethods : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod()]
        public static string GetProductsFromKimtec()
        {
            try
            {
                string status = new KimtecBL().SaveProductsFromKimtec();
                Configuration configuration = WebConfigurationManager.OpenWebConfiguration("/");
                configuration.AppSettings.Settings["productsLoaded"].Value = DateTime.Now.AddHours(9).ToString("dd/MM/yyyy hh:mm");
                configuration.Save();

                return JsonConvert.SerializeObject(status);
            }
            catch
            {
                throw;
            }
        }

        [WebMethod()]
        public static string GetProductsSpecificationFromKimtec()
        {
            try
            {
                new KimtecBL().SaveProductSpecification();
                new KimtecBL().SaveKimtecAttribute();
                return JsonConvert.SerializeObject("Specification successfully saved");
            }
            catch
            {
                throw;
            }
        }

        [WebMethod()]
        public static string GetCategoriesFromKimtec()
        {
            try
            {
                DataSet categories = new KimtecBL().GetCategoriesFromKimtec();
                return JsonConvert.SerializeObject("Preuzeto " + categories.Tables[0].Rows.Count + " kategorija");
            }
            catch
            {
                throw;
            }
        }

        [WebMethod()]
        public static string SaveProduct(string code, bool isApproved, bool isActive, int categoryID)
        {
            try
            {
                bool saved = new EweBL().SaveProduct(code, isApproved, isActive, categoryID);
                return saved ? "Saved" : "Not saved";
            }
            catch(Exception ex)
            {
                return "Not saved. " + ex.Message;
                //throw new Exception("Error: Code " + code + ". " + ex.Message);
            }
        }

        [WebMethod()]
        public static string SaveProductKimtec(string code, bool isApproved, bool isActive, int categoryID, int kimtecCategoryID)
        {
            try
            {
                new KimtecBL().SaveProduct(code, isActive, isApproved, categoryID, kimtecCategoryID);
                return "Saved";
            }
            catch(Exception ex)
            {
                throw new Exception("Error: Code " + code);
            }
        }

        [WebMethod]
        public static string SaveProductThreeg(string code, bool isApproved, bool isActive, int categoryID)
        {
            try
            {
                bool saved = new ThreegBL().SaveProduct(code, isApproved, isActive, categoryID);
                return saved ? "Saved" : "Not saved";
            }
            catch(Exception ex)
            {
                return "Not saved. " + ex.Message;
            }
        }

        [WebMethod()]
        public static bool ChangeCategory(int productID, int newCategoryID)
        {
            try
            { 
                return new ProductBL().ChangeCategory(productID, newCategoryID);
            }
            catch(Exception ex)
            {
                throw new Exception("Error: " + productID);
            }
        }

        public static string GetProductsByNameAndCode(string name)
        {
            try
            {
                return JsonConvert.SerializeObject(new ProductBL().GetProductsByNameAndCode(name));
            }
            catch(Exception ex)
            {
                ErrorLog.LogError(ex);
                throw;
            }
        }

        [WebMethod()]
        public static string SaveImportProduct(string supplierCode, string productCode, bool isApproved, bool isActive, int categoryID)
        {
            IProductImportBL productImportBL = null;

            switch (supplierCode)
            {
                case "uspon":
                    {
                        productImportBL = new ProductImportUsponBL();
                        break;
                    }
                case "dsc":
                    {
                        productImportBL = new ProductImportDSCBL();
                        break;
                    }
                //case "ewe":
                //    {
                //        productImportBL = new ProductImportEweBL();
                //        break;
                //    }
                case "ewe":
                    {
                        productImportBL = new ProductImportEweV2BL();
                        break;
                    }
            }

            productImportBL.SaveProduct(productCode, isApproved, isActive, categoryID);

            return "success";
        }

        [WebMethod()]
        public static bool SetActive(int productID, bool isActive)
        {
            ProductBL productBL = new ProductBL();

            productBL.SetActive(productID, isActive);

            return true;
        }

        [WebMethod()]
        public static bool SetApproved(int productID, bool isApproved)
        {
            ProductBL productBL = new ProductBL();

            productBL.SetApproved(productID, isApproved);

            return true;
        }

        [WebMethod()]
        public static bool SetIsInStock(int productID, bool isInStock)
        {
            ProductBL productBL = new ProductBL();

            productBL.SetIsInStock(productID, isInStock);

            return true;
        }

        [WebMethod()]
        public static bool SetIsLocked(int productID, bool isLocked)
        {
            ProductBL productBL = new ProductBL();

            productBL.SetLocked(productID, isLocked);

            return true;
        }

        [WebMethod()]
        public static bool SetIsPriceLocked(int productID, bool isPriceLocked)
        {
            ProductBL productBL = new ProductBL();

            productBL.SetPriceLocked(productID, isPriceLocked);

            return true;
        }

        [WebMethod()]
        public static bool SetSortIndex(int productID, int sortIndex)
        {
            ProductBL productBL = new ProductBL();

            productBL.SetSortIndex(productID, sortIndex);

            return true;
        }

        [WebMethod()]
        public static bool DeleteProduct(int productID)
        {
            new ProductBL().DeleteProduct(productID);

            return true;
        }
    }
}
