using System;
using System.Text;
using Microsoft.Data.SqlClient;

namespace P03.MinionNames
{
    class Program
    {
        static void Main(string[] args)
        {
            string connectionString = @"Server=.;Database=MinionsDB;Integrated Security=true;";

            using SqlConnection sqlConnection = new SqlConnection(connectionString);

            sqlConnection.Open();

            int villainId = int.Parse(Console.ReadLine());

            string getVillain = "SELECT [Name] FROM Villains WHERE Id = @villainId";
            SqlCommand getVillainCmd = new SqlCommand(getVillain, sqlConnection);
            getVillainCmd.Parameters.AddWithValue("@villainId", villainId);

            string villainName = (string)getVillainCmd.ExecuteScalar();

            if (villainName == null)
            {
                Console.WriteLine($"No villain with ID {villainId} exists in the database.");
                return;
            }

            string getMinions = @"SELECT m.[Name],
		                                    m.Age
	                                    FROM Minions AS m
	                                    JOIN MinionsVillains AS mv ON m.Id = mv.MinionId
	                                    JOIN Villains AS v ON mv.VillainId = v.Id
	                                    WHERE v.Id = @villainId
	                                    ORDER BY m.[Name] ASC";

            SqlCommand getMinionsCmd = new SqlCommand(getMinions, sqlConnection);
            getMinionsCmd.Parameters.AddWithValue("@villainId", villainId);
            SqlDataReader reader = getMinionsCmd.ExecuteReader();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine($"Villain: {villainName}");

            if (reader.HasRows)
            {
                int counter = 1;

                while (reader.Read())
                {
                    string minionName = (string)reader["Name"];
                    int age = (int)reader["Age"];

                    sb.AppendLine($"{counter}. {minionName} {age}");
                    counter++;
                }
            }
            else
            {
                sb.AppendLine("(no minions)");
            }

            Console.WriteLine(sb.ToString().TrimEnd());
        }
    }
}
