using Microsoft.Data.SqlClient;
using System;

namespace P06.RemoveVillain
{
    class Program
    {
        private const string connectionString = @"Server=.;Database=MinionsDB;Integrated Security=true;";

        static void Main(string[] args)
        {
            int villainToRemoveId = int.Parse(Console.ReadLine());

            using SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();

            SqlTransaction transaction = connection.BeginTransaction(); 

            string getVillainNameQuery = "SELECT [Name] FROM Villains WHERE Id = @villainId";
            SqlCommand getNameCmd = new SqlCommand(getVillainNameQuery, connection,transaction);
            getNameCmd.Parameters.AddWithValue("@villainId", villainToRemoveId);

            string villainName = getNameCmd.ExecuteScalar()?.ToString();

            if (villainName == null)
            {
                Console.WriteLine("No such villain was found.");
                return;
            }

            string deleteMinionsVillainsQuery = "DELETE FROM MinionsVillains WHERE VillainId = @villainId";
            SqlCommand deletMinVilCmd = new SqlCommand(deleteMinionsVillainsQuery, connection,transaction);
            deletMinVilCmd.Parameters.AddWithValue("@villainId", villainToRemoveId);

            int minionsCount = deletMinVilCmd.ExecuteNonQuery();

            string deleteVillainsQuery = "DELETE FROM Villains WHERE Id = @villainId";
            SqlCommand deleteVillainCmd = new SqlCommand(deleteVillainsQuery, connection, transaction);
            deleteVillainCmd.Parameters.AddWithValue("@villainId", villainToRemoveId);
            deleteVillainCmd.ExecuteNonQuery();

            Console.WriteLine($"{villainName} was deleted.");
            Console.WriteLine($"{minionsCount} minions were released.");

            transaction.Commit();
        }
    }
}
