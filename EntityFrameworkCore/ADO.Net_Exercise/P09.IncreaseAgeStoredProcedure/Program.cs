using Microsoft.Data.SqlClient;     
using System;

namespace P09.IncreaseAgeStoredProcedure
{
    class Program
    {
        private const string connectionString = @"Server=.;Database=MinionsDB;Integrated Security=true;";

        static void Main(string[] args)
        {
            int id = int.Parse(Console.ReadLine());

            SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();

            string updateQuery = "usp_GetOlder";
            SqlCommand updateCommand = new SqlCommand(updateQuery, connection);
            updateCommand.CommandType = System.Data.CommandType.StoredProcedure;
            updateCommand.Parameters.AddWithValue("@Id", id);
            updateCommand.ExecuteNonQuery();

            string getMinionQuery = "SELECT [Name], Age FROM Minions WHERE Id = @Id";
            SqlCommand getMinionCommand = new SqlCommand(getMinionQuery, connection);
            getMinionCommand.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = getMinionCommand.ExecuteReader();

            while (reader.Read())
            {
                Console.WriteLine($"{reader["Name"]} - {reader["Age"]} years old");

            }
        }
    }
}
