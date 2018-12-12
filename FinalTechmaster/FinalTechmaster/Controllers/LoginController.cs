using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FinalTechmaster.Model;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FinalTechmaster.Controllers
{
    [Route("api/[controller]")]
    public class LoginController : Controller
    {
        // GET: api/values
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        [HttpPost]
        public ReturnData Post([FromBody]UserLogin value)
        {
            if (value.Username == "toannd")
            {
                if (value.Password == "1")
                {
                    return new ReturnData() { Success = true };
                }
                else
                {
                    return new ReturnData() { Success = false, Data = new { Message = "Wrong password" } };
                }
            }
            return new ReturnData() { Success = false, Data = new { Message = "Login fail. Try again!" } };
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
