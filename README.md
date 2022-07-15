# WowTrader DB

## Config DB

1. Connect with root privileges, create db and user:
    ```sql
    CREATE DATABASE wowtrader;
    CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON wowtrader.* TO 'user'@'localhost';
    FLUSH PRIVILEGES;
    ```

2. Open `application.properties` in WOWSnifferServer and set db name, user, password:
    ```
    spring.datasource.url=jdbc:mysql://localhost:3306/wowtrader
    spring.datasource.username=user
    spring.datasource.password=password
    ```
3. Run rebuild jar package: `mvn package`

4. Run WOWSnifferServer, hibernate ORM creates db schema.

5. Insert data from backup (Reference tables)
   ```
   mysql -u root -p wowtrader < db/ref_tables.sql
   ```
6. DB ready.

## Reference tables

- item
- item_class
- item_subclass
- item_cost (vendor records)
- spell
- spell_has_alt_spell
- spell_need_subspell
- component

Backup:
```
mysqldump -u root -p wowtrader item item_class item_subclass item_cost spell spell_has_alt_spell spell_need_subspell component > db/ref_tables.sql
```

## Tables for temp game data

- game_character
- game_character_spell_set
- item_cost (auction records)
- item_for_sale
- item_profit_action

## Tables for statistics

- item_history
- trade_history_record

Backup to file:
```
mysqldump -u root -p wowtrader item_history trade_history_record > history.sql
```
Restore from file:
```
mysql -u root -p wowtrader < history.sql
```