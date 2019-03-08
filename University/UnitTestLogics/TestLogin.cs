using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Logics;
namespace UnitTestLogics
{
    [TestClass]
    public class TestLogin
    {
        [TestMethod]
        public void TestLoginAndConnect()
        {
            Logics.Login.Auth auth = new Logics.Login.Auth();
            Logics.Functions.Connection.ConnectionDB con;
             Assert.AreEqual(true, auth.Login("postgres","1",out con));
            
        }
    }
}
