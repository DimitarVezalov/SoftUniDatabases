using System;
using System.Linq;
using Microsoft.Data.SqlClient;

namespace P04.AddMinion
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] minionArgs = Console.ReadLine()
               .Split(new char[] { ' ', ':' }, StringSplitOptions.RemoveEmptyEntries)
               .Skip(1)
               .ToArray();

            string minionName = minionArgs[0];
            int minionAge = int.Parse(minionArgs[1]);
            string town = minionArgs[2];

            string villainName = Console.ReadLine()
                .Split(": ", StringSplitOptions.RemoveEmptyEntries)
                .Last();

            string connectionString = @"Server=.;Database=MinionsDB;Integrated Security=true;";

            using SqlConnection sqlConnection = new SqlConnection(connectionString);

            sqlConnection.Open();
 
            string getTownIdQuery = "SELECT Id FROM Towns WHERE [Name] = @townName";
            SqlCommand getTownIdCmd = new SqlCommand(getTownIdQuery, sqlConnection);
            getTownIdCmd.Parameters.AddWithValue("@townName", town);

            string townId = EnsureTownExists(town, sqlConnection, getTownIdCmd);

            string getVillainIdQuery = "SELECT Id FROM Villains WHERE [Name] = @villainName";
            SqlCommand getVillainIdCmd = new SqlCommand(getVillainIdQuery, sqlConnection);
            getVillainIdCmd.Parameters.AddWithValue("@villainName", villainName);

            string villainId = EnsureVillainExists(villainName, sqlConnection, getVillainIdCmd);

            InsertMinion(minionName, minionAge, sqlConnection, townId);

            string minionId = GetMinionId(minionName, sqlConnection);

            InsertMinionVillain(sqlConnection, villainId, minionId);

            Console.WriteLine($"Successfully added {minionName} to be minion of {villainName}.");


        }

        private static void InsertMinionVillain(SqlConnection sqlConnection, string villainId, string minionId)
        {
            string insertMinionVillain = "INSERT INTO MinionsVillains (MinionId, VillainId) " +
                                                                        "VALUES (@minionId, @villainId)";

            SqlCommand insertMinionVillainCmd = new SqlCommand(insertMinionVillain, sqlConnection);
            insertMinionVillainCmd.Parameters.AddWithValue("@minionId", int.Parse(minionId));
            insertMinionVillainCmd.Parameters.AddWithValue("@villainId", int.Parse(villainId));

            int result = insertMinionVillainCmd.ExecuteNonQuery();
        }

        private static string GetMinionId(string minionName, SqlConnection sqlConnection)
        {
            string getMinionIdQuery = "SELECT Id FROM Minions WHERE [Name] LIKE @minionName";
            SqlCommand getMinionIdCmd = new SqlCommand(getMinionIdQuery, sqlConnection);
            getMinionIdCmd.Parameters.AddWithValue("@minionName", minionName);

            string minionId = getMinionIdCmd.ExecuteScalar()?.ToString();
            return minionId;
        }

        private static void InsertMinion(string minionName, int minionAge, SqlConnection sqlConnection, string townId)
        {
            string insertMinion = "INSERT INTO Minions (Name,Age, TownId) VALUES(@name, @age, @townId)";
            SqlCommand insertMinionCmd = new SqlCommand(insertMinion, sqlConnection);
            insertMinionCmd.Parameters.AddWithValue("@name", minionName);
            insertMinionCmd.Parameters.AddWithValue("@age", minionAge);
            insertMinionCmd.Parameters.AddWithValue("@townId", townId);
            int minionsAdded = insertMinionCmd.ExecuteNonQuery();
        }

        private static string EnsureVillainExists(string villainName, SqlConnection sqlConnection, SqlCommand checkVillainCmd)
        {
            string currentVillainId = checkVillainCmd.ExecuteScalar()?.ToString();

            if (currentVillainId == null)
            {
                currentVillainId = InsertVillain(villainName, sqlConnection, checkVillainCmd);
            }

            return currentVillainId;
        }

        private static string InsertVillain(string villainName, SqlConnection sqlConnection, SqlCommand checkVillainCmd)
        {
            string currentVillainId;
            string insertVillain = "INSERT INTO Villains (Name, EvilnessFactorId) " +
                                     "VALUES (@villainName,4)";

            SqlCommand insertVillainCmd = new SqlCommand(insertVillain, sqlConnection);
            insertVillainCmd.Parameters.AddWithValue("@villainName", villainName);
            int insertedVillains = insertVillainCmd.ExecuteNonQuery();

            Console.WriteLine($"Villain {villainName} was added to the database.");

            currentVillainId = checkVillainCmd.ExecuteScalar()?.ToString();
            return currentVillainId;
        }

        private static string EnsureTownExists(string town, SqlConnection sqlConnection, SqlCommand checkTownCmd)
        {
            string currentTownId = checkTownCmd.ExecuteScalar()?.ToString();

            if (currentTownId == null)
            {
                currentTownId = InsertTown(town, sqlConnection, checkTownCmd);
            }

            return currentTownId;
        }

        private static string InsertTown(string town, SqlConnection sqlConnection, SqlCommand checkTownCmd)
        {
            string currentTownId;
            string insertTown = "INSERT INTO Towns ([Name], CountryCode) VALUES (@townName, 1)";
            SqlCommand insertTownCmd = new SqlCommand(insertTown, sqlConnection);
            insertTownCmd.Parameters.AddWithValue("@townName", town);
            int insertedTowns = insertTownCmd.ExecuteNonQuery();

            Console.WriteLine($"Town {town} was added to the database.");

            currentTownId = checkTownCmd.ExecuteScalar()?.ToString();
            return currentTownId;
        }
    }
}
