using FlightManagement.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FlightManagement.Service
{
public interface IFlightService
    {
        Task<User> AuthenticateUserAsync(string userName, string password);
        Task<List<Flight>> GetAllFlightsAsync();
        Task<Flight> GetFlightByIdAsync(int flightId);
        Task AddFlightAsync(Flight flight);
        Task UpdateFlightAsync(Flight flight);

    }
}
