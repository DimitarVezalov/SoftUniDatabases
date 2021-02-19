using System;
using Microsoft.Data.SqlClient;

namespace P02.VillainNames
{
    class Program
    {
        static void Main(string[] args)
        {
            string connectionString = @"Server=.;Database=MinionsDB;Integrated Security=true;";

            using SqlConnection sqlConnection = new SqlConnection(connectionString);

            sqlConnection.Open();

            string getVillainNames = @"SELECT v.[Name],
		                                    COUNT(*) AS [MinionsCount]
	                                    FROM Villains AS v
	                                    JOIN MinionsVillains AS mv ON v.Id = mv.MinionId
	                                    JOIN Minions AS m ON mv.MinionId = m.Id
	                                    GROUP BY v.Name
	                                    ORDER BY MinionsCount DESC";

            SqlCommand sqlCommand = new SqlCommand(getVillainNames, sqlConnection);

            SqlDataReader reader = sqlCommand.ExecuteReader();

            while (reader.Read())
            {
                string name = (string)reader["Name"];
                int minionsCount = (int)reader["MinionsCount"];

                Console.WriteLine($"{name} - {minionsCount}");
            }



        }
    }
}
