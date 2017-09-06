using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;


    public abstract class SqlHelper
    {
        private static Hashtable parmCache = Hashtable.Synchronized(new Hashtable());

        public static int ExecuteNonQuery(string connectionString, CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand sqlCommand = new SqlCommand();
            int result;
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlHelper.PrepareCommand(sqlCommand, sqlConnection, null, cmdType, cmdText, commandParameters);
                int num = sqlCommand.ExecuteNonQuery();
                sqlCommand.Parameters.Clear();
                result = num;
            }
            return result;
        }

        public static int SQLBulkCopy(DataTable dttbl, string destinnationTbl, string connectionstring)
        {
            int num = 0;
            int result;
            try
            {
                SqlConnection sqlConnection = new SqlConnection(connectionstring);
                if (sqlConnection.State != ConnectionState.Open)
                {
                    sqlConnection.Open();
                }
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(sqlConnection))
                {
                    sqlBulkCopy.DestinationTableName = destinnationTbl;
                    sqlBulkCopy.WriteToServer(dttbl);
                }
                result = num;
            }
            catch
            {
                throw;
            }
            return result;
        }

        public static int ExecuteNonQuery(SqlConnection connection, CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand sqlCommand = new SqlCommand();
            SqlHelper.PrepareCommand(sqlCommand, connection, null, cmdType, cmdText, commandParameters);
            int result = sqlCommand.ExecuteNonQuery();
            sqlCommand.Parameters.Clear();
            return result;
        }

        public static int ExecuteNonQuery(SqlTransaction trans, CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand sqlCommand = new SqlCommand();
            SqlHelper.PrepareCommand(sqlCommand, trans.Connection, trans, cmdType, cmdText, commandParameters);
            int result = sqlCommand.ExecuteNonQuery();
            sqlCommand.Parameters.Clear();
            return result;
        }

        public static SqlDataReader ExecuteReader(SqlTransaction trans, CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlDataReader result;
            try
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    SqlHelper.PrepareCommand(sqlCommand, trans.Connection, trans, cmdType, cmdText, commandParameters);
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader(CommandBehavior.Default);
                    sqlCommand.Parameters.Clear();
                    result = sqlDataReader;
                }
            }
            catch
            {
                throw;
            }
            return result;
        }

        public static SqlDataReader ExecuteReader(string connectionString, CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlConnection sqlConnection = new SqlConnection(connectionString);
            SqlDataReader result;
            try
            {
                using (SqlCommand sqlCommand = new SqlCommand())
                {
                    if (sqlConnection.State != ConnectionState.Open)
                    {
                        sqlConnection.Open();
                    }
                    else
                    {
                        sqlConnection.Close();
                        sqlConnection.Open();
                    }
                    SqlHelper.PrepareCommand(sqlCommand, sqlConnection, null, cmdType, cmdText, commandParameters);
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader(CommandBehavior.CloseConnection);
                    sqlCommand.Parameters.Clear();
                    result = sqlDataReader;
                }
            }
            catch (Exception ex)
            {
                sqlConnection.Close();
                throw;
            }
            return result;
        }

        public static object ExecuteScalar(string connectionString, CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand sqlCommand = new SqlCommand();
            object result;
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlHelper.PrepareCommand(sqlCommand, sqlConnection, null, cmdType, cmdText, commandParameters);
                object obj = sqlCommand.ExecuteScalar();
                sqlCommand.Parameters.Clear();
                result = obj;
            }
            return result;
        }

        public static object ExecuteScalar(SqlConnection connection, CommandType cmdType, string cmdText, params SqlParameter[] commandParameters)
        {
            SqlCommand sqlCommand = new SqlCommand();
            SqlHelper.PrepareCommand(sqlCommand, connection, null, cmdType, cmdText, commandParameters);
            object result = sqlCommand.ExecuteScalar();
            sqlCommand.Parameters.Clear();
            return result;
        }

        public static void CacheParameters(string cacheKey, params SqlParameter[] commandParameters)
        {
            SqlHelper.parmCache[cacheKey] = commandParameters;
        }

        public static SqlParameter[] GetCachedParameters(string cacheKey)
        {
            SqlParameter[] array = (SqlParameter[])SqlHelper.parmCache[cacheKey];
            if (array == null)
            {
                return null;
            }
            SqlParameter[] array2 = new SqlParameter[array.Length];
            int i = 0;
            int num = array.Length;
            while (i < num)
            {
                array2[i] = (SqlParameter)((ICloneable)array[i]).Clone();
                i++;
            }
            return array2;
        }

        private static void PrepareCommand(SqlCommand cmd, SqlConnection conn, SqlTransaction trans, CommandType cmdType, string cmdText, SqlParameter[] cmdParms)
        {
            if (conn.State != ConnectionState.Open)
            {
                conn.Open();
            }
            cmd.Connection = conn;
            cmd.CommandTimeout = 100;
            cmd.CommandText = cmdText;
            if (trans != null)
            {
                cmd.Transaction = trans;
            }
            cmd.CommandType = cmdType;
            if (cmdParms != null)
            {
                for (int i = 0; i < cmdParms.Length; i++)
                {
                    SqlParameter value = cmdParms[i];
                    cmd.Parameters.Add(value);
                }
            }
        }
    }
