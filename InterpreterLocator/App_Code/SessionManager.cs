using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using Entities;
using Business;


/// <summary>
/// Class manages all session keys, ideally it should not come in the BL, 
/// but adding another project just for compilable code which is only 
/// web application specific seems like an overkill.
/// </summary>

public class SessionManager
{
    private const string CURRENT_USER_KEY = "CurrentUser";


    /// <summary>
    ///Reloads the user in current session
    ///from the database, to be called after modifying any user data.
    /// </summary>
    public static void ReloadCurrentUserData()
    {
        //  InventionsUser currentUser = InventionsUserBL.GetByNetworkID(HttpContext.Current.User.Identity.Name);
      //  HttpContext.Current.Session[CURRENT_USER_KEY] = currentUser;
    }

    /// <summary>
    /// Always gets the user in session, if user is not in session gets from the database puts in the session
    /// </summary>
    /// <returns>current logged in user</returns>
    /// 

        public static void SetLoggedInUser(Employee toSet)
    {
        HttpContext.Current.Session[CURRENT_USER_KEY] = toSet;
    }
    public static Employee GetCurrentUser()
    {
        if (HttpContext.Current.Session[CURRENT_USER_KEY] == null)
        {
           //login page
           // HttpContext.Current.Session[CURRENT_USER_KEY] = currentUser;
        }
        return (Employee)HttpContext.Current.Session[CURRENT_USER_KEY];
    }
}

        /// <summary>
        /// current patent selected
        /// </summary>
     
