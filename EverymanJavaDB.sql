import java.sql.*;

public class TradeDatabaseHelper {

    private static final String DATABASE_NAME = "mydb";

    public static void createDatabase() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:sqlite:" + DATABASE_NAME);

        connection.createStatement().executeUpdate("CREATE TABLE IF NOT EXISTS tblMembers (\n" +
                "MemberID INTEGER PRIMARY KEY AUTOINCREMENT,\n" +
                "MemberType ENUM ('Free', 'Paid'),\n" +
                "DateAndTimeJoined DATETIME DEFAULT CURRENT_TIMESTAMP,\n" +
                "MostRecentPayment DATETIME,\n" +
                "SubscriptionExpiryDate DATETIME,\n" +
                "Currency ENUM,\n" +
                "AmountPaid DECIMAL,\n" +
                "E-mailAddress CHAR(30) UNIQUE,\n" +
                "RegistrationIPaddress CHAR(32) UNIQUE,\n" +
                "DisplayName CHAR(15),\n" +
                "Password CHAR(15),\n" +
                "PasswordHint CHAR(30),\n" +
                "AccountBalance DECIMAL,\n" +
                "NumberOfDaysMembership SMALLINT UNSIGNED,\n" +
                "MessagesCreatedSinceJoining SMALLINT UNSIGNED,\n" +
                "MessagesForwardedSinceJoining SMALLINT UNSIGNED,\n" +
                "MessagesIgnoredSinceJoining SMALLINT UNSIGNED,\n" +
                "MessagesReportedSinceJoining SMALLINT UNSIGNED\n" +
                ");");

        connection.createStatement().executeUpdate("CREATE TABLE IF NOT EXISTS tblPasswordHistory (\n" +
                "MemberID INTEGER PRIMARY KEY AUTOINCREMENT,\n" +
                "Password CHAR(15),\n" +
                "PasswordHint CHAR(30),\n" +
                "DateCreated DATETIME\n" +
                ");");

        connection.createStatement().executeUpdate("CREATE TABLE IF NOT EXISTS tblOpenPositions (\n" +
                "PrimaryKey INTEGER PRIMARY KEY AUTOINCREMENT,\n" +
                "MemberId INTEGER NOT NULL,\n" +
                "SecurityName CHAR(15) NOT NULL,\n" +
                "TickerSymbol CHAR(4) NOT NULL,\n" +
                "ISIN CHAR(12) NOT NULL,\n" +
                "ExchangeName ENUM,\n" +
                "MIC CHAR(4) NOT NULL,\n" +
                "SecurityType ENUM ('share', 'bond', 'commodity', 'future'),\n" +
                "PositionType ENUM ('Long', 'Short'),\n" +
                "DatePurchased DATETIME DEFAULT CURRENT_TIMESTAMP,\n" +
                "Quantity SMALLINT NOT NULL,\n" +
                "StrikePrice DECIMAL PER UNIT,\n" +
                "NotionalTransactionCost DECIMAL,\n" +
                "CurrentPrice DECIMAL PER UNIT\n" +
                ");");

        connection.createStatement().executeUpdate("CREATE TABLE IF NOT EXISTS tblTransactions (\n" +
                "PrimaryKey INTEGER PRIMARY KEY AUTOINCREMENT,\n" +
                "MemberId INTEGER NOT NULL,\n" +
                "SecurityName CHAR(15) NOT NULL,\n" +
                "TickerSymbol CHAR(4) NOT NULL,\n" +
                "ISIN CHAR(12) NOT NULL,\n" +
                "ExchangeName ENUM,\n" +
                "MIC CHAR(4) NOT NULL,\n" +
                "SecurityType ENUM ('share', 'bond', 'commodity', 'future'),\n" +
                "PositionType ENUM ('Long', 'Short'),\n" +
                "DateOpened DATETIME DEFAULT CURRENT_TIMESTAMP,\n" +
                "Quantity SMALLINT NOT NULL,\n" +
                "StrikePrice DECIMAL PER UNIT,\n" +
                "NotionalTransactionCost DECIMAL,\n" +
                "ClosePrice DECIMAL PER UNIT,\n" +
                "DateClosed DATETIME\n" +
                ");");

                       connection.createStatement().executeUpdate("CREATE TABLE IF NOT EXISTS tblPrimaryMessages (\n" +
                       "MessageID INTEGER PRIMARY KEY AUTOINCREMENT,\n" +
                       "AuthorID BIGINT NOT NULL,\n" +
                       "Security CHAR(12) NOT NULL,\n" +
                       "Content VARCHAR(2000) NOT NULL\n" +
                       ");");

               connection.createStatement().executeUpdate("CREATE TABLE IF NOT EXISTS tblForwardedMessage (\n" +
                       "ThisMessageID SERIAL,\n" +
                       "ParentMessageID BIGINT NOT NULL,\n" +
                       "ForwarderID BIGINT NOT NULL,\n" +
                       "Content VARCHAR(2000) NULL\n" +
                       ");");

               connection.createStatement().executeUpdate("CREATE TABLE IF NOT EXISTS tblMessageLife (\n" +
                       "PrimaryMessageID BIGINT NOT NULL,\n" +
                       "ImmediateParentID BIGINT NULL,\n" +
                       "Recipient BIGINT NOT NULL,\n" +
                       "Action ENUM ('Pass-on', 'Pass-back', 'Ignore', 'Report') NOT NULL\n" +
                       ");");

               connection.createStatement().executeUpdate("CREATE TABLE IF NOT EXISTS tblMemberWarnings (\n" +
                       "MemberID BIGINT NOT NULL,\n" +
                       "DateOrWarning TIMESTAMP NOT NULL,\n" +
                       "WarningText VARCHAR(2000) NOT NULL,\n" +
                       "AdditionalInfo VARCHAR(255) NULL\n" +
                       ");");

               connection.createStatement().executeUpdate("CREATE TABLE IF NOT EXISTS tblMemberBans (\n" +
                       "MemberID BIGINT NOT NULL,\n" +
                       "RegistrationIPaddress CHAR(32) NOT NULL,\n" +
                       "DisplayName CHAR(15) NOT NULL,\n" +
                       "Password CHAR(15) NOT NULL,\n" +
                       "PasswordHint CHAR(30) NOT NULL,\n" +
                       "DateBanned TIMESTAMP NOT NULL,\n" +
                       "ReasonForBan VARCHAR(2000) NOT NULL\n" +
                       ");");
    }
}
