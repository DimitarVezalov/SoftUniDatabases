using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;

namespace P07.PrintAllMinionNames
{
    class Program
    {
        private const string connectionString = @"Server=.;Database=MinionsDB;Integrated Security=true;";

        static void Main(string[] args)
        {
            using SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();

            string getMinionNamesQuery = "SELECT [Name] FROM Minions";
            SqlCommand command = new SqlCommand(getMinionNamesQuery, connection);
            SqlDataReader reader = command.ExecuteReader();

            List<string> names = new List<string>();

            while (reader.Read())
            {
                names.Add(reader["Name"].ToString());
            }

            for (int i = 0; i < names.Count / 2; i++)
            {
                Console.WriteLine(names[i]);
                Console.WriteLine(names[names.Count - 1 - i]);
            }

            if (names.Count % 2 != 0)
            {
                Console.WriteLine(names[names.Count / 2]);
            }

        }
    }
}
