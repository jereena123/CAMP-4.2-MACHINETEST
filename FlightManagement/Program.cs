using FlightManagement.Model;
using FlightManagement.Repository;
using FlightManagement.Service;
using FlightManagement.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Threading.Tasks;

namespace FlightManagement
{
    public class Program
    {

        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["CSHARPWINDOW"].ConnectionString;
        private static readonly IFlightRepository FlightRepository = new FlightRepository(connectionString);
        private static readonly IFlightService FlightService = new FlightService(FlightRepository);

        static async Task Main(string[] args)
        {
            await LoginAsync();
            await MenuAsync(args);
        }

        private static async Task LoginAsync()
        {
            Console.Write("Username: ");
            var userName = Console.ReadLine();

            Console.Write("Password: ");
            var password = Console.ReadLine();

            var user = await FlightService.AuthenticateUserAsync(userName, password);

            if (user != null)
            {
                Console.WriteLine($"Welcome {user.UserName}. Your role is {user.RoleName}.");
            }
            else
            {
                Console.WriteLine("Invalid username or password.");
                Environment.Exit(1); 
            }
        }

        public static async Task MenuAsync(string[] args)
        {
            while (true)
            {
                Console.WriteLine("Admin Dashboard:");
                Console.WriteLine("1. List All Flights");
                Console.WriteLine("2. Search Flight By ID");
                Console.WriteLine("3. Add Flight");
                Console.WriteLine("4. Update Flight");
                Console.WriteLine("5. Exit");
                Console.Write("Select an option: ");

                var option = Console.ReadLine();

                switch (option)
                {
                    case "1":
                        await ListAllFlightsAsync();
                        break;

                    case "2":
                        await SearchFlightByIdAsync();
                        break;

                    case "3":
                        await AddFlightAsync();
                        break;

                    case "4":
                        await UpdateFlightAsync();
                        break;

                    case "5":
                        return;

                    default:
                        Console.WriteLine("Invalid option. Please try again.");
                        break;
                }
            }
        }

        private static async Task ListAllFlightsAsync()
        {
            Console.WriteLine("Fetching all flights...");
            var flights = await FlightService.GetAllFlightsAsync();

            foreach (var flight in flights)
            {
                Console.WriteLine($"Flight ID: {flight.FlightId}");
                Console.WriteLine($"Departure Airport: {flight.DepartureAirport}");
                Console.WriteLine($"Departure Date: {flight.DepartureDate:yyyy-MM-dd}");
                Console.WriteLine($"Departure Time: {flight.DepartureTime:hh\\:mm\\:ss}");
                Console.WriteLine($"Arrival Airport: {flight.ArrivalAirport}");
                Console.WriteLine($"Arrival Date: {flight.ArrivalDate:yyyy-MM-dd}");
                Console.WriteLine($"Arrival Time: {flight.ArrivalTime:hh\\:mm\\:ss}");
                Console.WriteLine();
            }
        }

        private static async Task SearchFlightByIdAsync()
        {
            Console.Write("Enter Flight ID to search: ");
            if (int.TryParse(Console.ReadLine(), out int flightId))
            {
                var flight = await FlightService.GetFlightByIdAsync(flightId);

                if (flight != null)
                {
                    Console.WriteLine($"Flight ID: {flight.FlightId}");
                    Console.WriteLine($"Departure Airport: {flight.DepartureAirport}");
                    Console.WriteLine($"Departure Date: {flight.DepartureDate:yyyy-MM-dd}");
                    Console.WriteLine($"Departure Time: {flight.DepartureTime:hh\\:mm\\:ss}");
                    Console.WriteLine($"Arrival Airport: {flight.ArrivalAirport}");
                    Console.WriteLine($"Arrival Date: {flight.ArrivalDate:yyyy-MM-dd}");
                    Console.WriteLine($"Arrival Time: {flight.ArrivalTime:hh\\:mm\\:ss}");
                }
                else
                {
                    Console.WriteLine("Flight not found.");
                }
            }
            else
            {
                Console.WriteLine("Invalid Flight ID.");
            }
        }

        private static async Task AddFlightAsync()
        {
            var flight = new Flight();

            Console.Write("Departure Airport: ");
            flight.DepartureAirport = Console.ReadLine();

            Console.Write("Departure Date (YYYY-MM-DD): ");
            flight.DepartureDate = DateTime.Parse(Console.ReadLine());

            Console.Write("Departure Time (HH:mm:ss): ");
            flight.DepartureTime = TimeSpan.ParseExact(Console.ReadLine(), @"hh\:mm\:ss", null);

            Console.Write("Arrival Airport: ");
            flight.ArrivalAirport = Console.ReadLine();

            Console.Write("Arrival Date (YYYY-MM-DD): ");
            flight.ArrivalDate = DateTime.Parse(Console.ReadLine());

            Console.Write("Arrival Time (HH:mm:ss): ");
            flight.ArrivalTime = TimeSpan.ParseExact(Console.ReadLine(), @"hh\:mm\:ss", null);

            try
            {
                await FlightService.AddFlightAsync(flight);
                Console.WriteLine("Flight added successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred while adding the flight: {ex.Message}");
            }
        }

        private static async Task UpdateFlightAsync()
        {
            Console.Write("Enter Flight ID to update: ");
            if (int.TryParse(Console.ReadLine(), out int flightId))
            {
                var flight = await FlightService.GetFlightByIdAsync(flightId);

                if (flight != null)
                {
                    Console.Write("New Departure Airport: ");
                    flight.DepartureAirport = Console.ReadLine();

                    Console.Write("New Departure Date (YYYY-MM-DD): ");
                    if (DateTime.TryParse(Console.ReadLine(), out DateTime depDate))
                    {
                        flight.DepartureDate = depDate;
                    }
                    else
                    {
                        Console.WriteLine("Invalid date format.");
                        return;
                    }

                    Console.Write("New Departure Time (HH:MM:SS): ");
                    if (TimeSpan.TryParse(Console.ReadLine(), out TimeSpan depTime))
                    {
                        flight.DepartureTime = depTime;
                    }
                    else
                    {
                        Console.WriteLine("Invalid time format.");
                        return;
                    }

                    Console.Write("New Arrival Airport: ");
                    flight.ArrivalAirport = Console.ReadLine();

                    Console.Write("New Arrival Date (YYYY-MM-DD): ");
                    if (DateTime.TryParse(Console.ReadLine(), out DateTime arrDate))
                    {
                        flight.ArrivalDate = arrDate;
                    }
                    else
                    {
                        Console.WriteLine("Invalid date format.");
                        return;
                    }

                    Console.Write("New Arrival Time (HH:MM:SS): ");
                    if (TimeSpan.TryParse(Console.ReadLine(), out TimeSpan arrTime))
                    {
                        flight.ArrivalTime = arrTime;
                    }
                    else
                    {
                        Console.WriteLine("Invalid time format.");
                        return;
                    }

                    await FlightService.UpdateFlightAsync(flight);
                    Console.WriteLine("Flight updated successfully.");
                }
                else
                {
                    Console.WriteLine("Flight not found.");
                }
            }
            else
            {
                Console.WriteLine("Invalid Flight ID.");
            }
        }
    }
}
