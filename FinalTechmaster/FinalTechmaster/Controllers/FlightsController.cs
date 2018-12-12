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
    public class FlightsController : Controller
    {
         private List<Flights> lstFlights = new List<Flights>{
                new Flights
            {
                FlightNo = "VN1",
                FlightDate = "01/12/2018",
                Sector = "HAN-SGN",
                FlightStatus = "takeoff"
            },
                new Flights
            {
                FlightNo = "VN2",
                FlightDate = "01/12/2018",
                Sector = "HAN-SGN",
                FlightStatus = "flight"
            },
                new Flights
            {
                FlightNo = "VN3",
                FlightDate = "01/12/2018",
                Sector = "HAN-SGN",
                FlightStatus = "landing"
            },
            new Flights
            {
                FlightNo = "VN4",
                FlightDate = "01/12/2018",
                Sector = "DAD-HAN",
                FlightStatus = "takeoff"
            },
            new Flights
            {
                FlightNo = "VN5",
                FlightDate = "01/12/2018",
                Sector = "CXR-SGN",
                FlightStatus = "landing"
            },
            new Flights
            {
                FlightNo = "VN6",
                FlightDate = "01/12/2018",
                Sector = "PQC-HAN",
                FlightStatus = "takeoff"
            },
            new Flights
            {
                FlightNo = "VN7",
                FlightDate = "01/12/2018",
                Sector = "SGN-HAN",
                FlightStatus = "landing"
            },
            new Flights
            {
                FlightNo = "VN8",
                FlightDate = "01/12/2018",
                Sector = "HAN-DAD",
                FlightStatus = "flight"
            }
        };

        // GET: api/values
        [HttpGet]
        public IEnumerable<Flights> Get()
        {
            return lstFlights;
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public Flights Get(string id)
        {
            return lstFlights.FirstOrDefault(x => x.FlightNo == id);
        }

        // POST api/values
        [HttpPost]
        public void Post([FromBody]string value)
        {
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
