using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;

namespace P05.ChangeTownNamesCasing
{
    class Program
    {
        private const string connectionString = @"Server=.;Database=MinionsDB;Integrated Security=true;";

        static void Main(string[] args)
        {
            string input = Console.ReadLine();

            using SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();

            string updateTownsQuery = "UPDATE Towns " +
                                            "SET Name = UPPER(Name) " +
                                            "WHERE CountryCode = " +
                                            "(SELECT c.Id FROM Countries AS c WHERE c.Name = @countryName)";

            SqlCommand command = new SqlCommand(updateTownsQuery, connection);
            command.Parameters.AddWithValue("@countryName", input);

            int townsAffected = command.ExecuteNonQuery();

            if (townsAffected == 0)
            {
                Console.WriteLine("No town names were affected.");
                return;
            }

            string getTownsQuery = "SELECT t.Name " +
                                        "FROM Towns as t " +
                                        "JOIN Countries AS c ON c.Id = t.CountryCode " +
                                        "WHERE c.Name = @countryName";

            command = new SqlCommand(getTownsQuery, connection);
            command.Parameters.AddWithValue("@countryName", input);
            SqlDataReader reader = command.ExecuteReader();

            List<string> towns = new List<string>();

            while (reader.Read())
            {
                towns.Add(reader["Name"].ToString());
            }

            Console.WriteLine($"{towns.Count} town names were affected.");
            Console.WriteLine($"[{string.Join(", ", towns)}]");
        }
    }
}
