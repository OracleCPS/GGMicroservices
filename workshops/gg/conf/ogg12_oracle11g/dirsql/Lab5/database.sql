DROP TABLE categories;
CREATE TABLE categories  (
  categories_id number(11) NOT NULL,
  categories_image varchar2(64),
  parent_id number(11) NOT NULL,
  sort_order number(3),
  date_added timestamp,
  last_modified timestamp,
  PRIMARY KEY (categories_id)
  using index
);

INSERT INTO categories VALUES (1,'category_hardware.gif',0,1,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (2,'category_software.gif',0,2,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (3,'category_dvd_movies.gif',0,3,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (4,'subcategory_graphic_cards.gif',1,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (5,'subcategory_printers.gif',1,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (6,'subcategory_monitors.gif',1,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (7,'subcategory_speakers.gif',1,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (8,'subcategory_keyboards.gif',1,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (9,'subcategory_mice.gif',1,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (10,'subcategory_action.gif',3,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (11,'subcategory_science_fiction.gif',3,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (12,'subcategory_comedy.gif',3,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (13,'subcategory_cartoons.gif',3,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (14,'subcategory_thriller.gif',3,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (15,'subcategory_drama.gif',3,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (16,'subcategory_memory.gif',1,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (17,'subcategory_cdrom_drives.gif',1,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (18,'subcategory_simulation.gif',2,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (19,'subcategory_action_games.gif',2,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (20,'subcategory_strategy.gif',2,0,timestamp'2011-04-04 08:31:00',NULL); 
INSERT INTO categories VALUES (21,'category_gadgets.png',0,4,timestamp'2011-04-04 08:31:00',NULL);
COMMIT;

DROP TABLE categories_description;
CREATE TABLE categories_description  (
  categories_id number(11) NOT NULL,
  language_id number(11) NOT NULL,
  categories_name varchar2(32) NOT NULL,
  PRIMARY KEY (categories_id,language_id)
  using index
);

INSERT INTO categories_description VALUES (1,1,'Hardware');
INSERT INTO categories_description VALUES (2,1,'Software');
INSERT INTO categories_description VALUES (3,1,'DVD Movies');
INSERT INTO categories_description VALUES (4,1,'Graphics Cards');
INSERT INTO categories_description VALUES (5,1,'Printers');
INSERT INTO categories_description VALUES (6,1,'Monitors');
INSERT INTO categories_description VALUES (7,1,'Speakers');
INSERT INTO categories_description VALUES (8,1,'Keyboards');
INSERT INTO categories_description VALUES (9,1,'Mice');
INSERT INTO categories_description VALUES (10,1,'Action');
INSERT INTO categories_description VALUES (11,1,'Science Fiction');
INSERT INTO categories_description VALUES (12,1,'Comedy');
INSERT INTO categories_description VALUES (13,1,'Cartoons');
INSERT INTO categories_description VALUES (14,1,'Thriller');
INSERT INTO categories_description VALUES (15,1,'Drama');
INSERT INTO categories_description VALUES (16,1,'Memory');
INSERT INTO categories_description VALUES (17,1,'CDROM Drives');
INSERT INTO categories_description VALUES (18,1,'Simulation');
INSERT INTO categories_description VALUES (19,1,'Action');
INSERT INTO categories_description VALUES (20,1,'Strategy');
INSERT INTO categories_description VALUES (21,1,'Gadgets');
COMMIT;

DROP TABLE products;
CREATE TABLE products (
  products_id number(11) NOT NULL,
  products_quantity number(4) NOT NULL,
  products_model varchar2(12),
  products_image varchar2(64),
  products_price number(15,4) NOT NULL,
  products_date_added timestamp NOT NULL,
  products_last_modified timestamp,
  products_date_available timestamp,
  products_weight number(5,2) NOT NULL,
  products_status number(1) NOT NULL,
  products_tax_class_id number(11) NOT NULL,
  manufacturers_id number(11),
  products_ordered number(11) NOT NULL,
  PRIMARY KEY (products_id)
  using index
);

INSERT INTO products VALUES (1,32,'MG200MMS','matrox/mg200mms.gif','299.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'23.00',1,1,1,0); 
INSERT INTO products VALUES (2,32,'MG400-32MB','matrox/mg400-32mb.gif','499.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'23.00',1,1,1,0); 
INSERT INTO products VALUES (3,2,'MSIMPRO','microsoft/msimpro.gif','49.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (4,13,'DVD-RPMK','dvd/replacement_killers.gif','42.0000',timestamp'2011-04-04 08:31:00',NULL,NULL,'23.00',1,1,2,0); 
INSERT INTO products VALUES (5,17,'DVD-BLDRNDC','dvd/blade_runner.gif','35.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (6,10,'DVD-MATR','dvd/the_matrix.gif','39.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (7,10,'DVD-YGEM','dvd/youve_got_mail.gif','34.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (8,10,'DVD-ABUG','dvd/a_bugs_life.gif','35.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (9,10,'DVD-UNSG','dvd/under_siege.gif','29.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (10,10,'DVD-UNSG2','dvd/under_siege2.gif','29.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (11,10,'DVD-FDBL','dvd/fire_down_below.gif','29.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (12,10,'DVD-DHWV','dvd/die_hard_3.gif','39.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,4,0); 
INSERT INTO products VALUES (13,10,'DVD-LTWP','dvd/lethal_weapon.gif','34.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (14,10,'DVD-REDC','dvd/red_corner.gif','32.0000',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (15,10,'DVD-FRAN','dvd/frantic.gif','35.0000',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (16,10,'DVD-CUFI','dvd/courage_under_fire.gif','38.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,4,0); 
INSERT INTO products VALUES (17,10,'DVD-SPEED','dvd/speed.gif','39.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,4,0); 
INSERT INTO products VALUES (18,10,'DVD-SPEED2','dvd/speed_2.gif','42.0000',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,4,0); 
INSERT INTO products VALUES (19,10,'DVD-TSAB','dvd/theres_something_about_mary.gif','49.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,4,0); 
INSERT INTO products VALUES (20,10,'DVD-BELOVED','dvd/beloved.gif','54.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,3,0); 
INSERT INTO products VALUES (21,16,'PC-SWAT3','sierra/swat_3.gif','79.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,7,0); 
INSERT INTO products VALUES (22,13,'PC-UNTM','gt_interactive/unreal_tournament.gif','89.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'7.00',1,1,8,0); 
INSERT INTO products VALUES (23,16,'PC-TWOF','gt_interactive/wheel_of_time.gif','99.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'10.00',1,1,8,0); 
INSERT INTO products VALUES (24,17,'PC-DISC','gt_interactive/disciples.gif','90.0000',timestamp'2011-04-04 08:31:00',NULL,NULL,'8.00',1,1,8,0); 
INSERT INTO products VALUES (25,16,'MSINTKB','microsoft/intkeyboardps2.gif','69.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'8.00',1,1,2,0); 
INSERT INTO products VALUES (26,10,'MSIMEXP','microsoft/imexplorer.gif','64.9500',timestamp'2011-04-04 08:31:00',NULL,NULL,'8.00',1,1,2,0); 
INSERT INTO products VALUES (27,7,'HPLJ1100XI','hewlett_packard/lj1100xi.gif','499.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'45.00',1,1,9,1); 
INSERT INTO products VALUES (28,100,'GT-P1000','samsung/galaxy_tab.gif','749.9900',timestamp'2011-04-04 08:31:00',NULL,NULL,'1.00',1,1,10,0);
COMMIT;

UPDATE products SET products_quantity = 9999;
UPDATE products SET products_quantity = 29 where products_id = 27;
COMMIT;

DROP TABLE products_description;
CREATE TABLE products_description  (
  products_id number(11) NOT NULL,
  language_id number(11) NOT NULL,
  products_name varchar2(64) NOT NULL,
  products_description varchar2(4000),
  products_url varchar2(255),
  products_viewed number(5),
  PRIMARY KEY (products_id,language_id)
  using index
);

INSERT INTO products_description VALUES (1,1,'Matrox G200 MMS','Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8 PCI board.<br /><br />With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br /><br />Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters  Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.','www.matrox.com/mga/products/g200_mms/home.cfm',0); 
INSERT INTO products_description VALUES (2,1,'Matrox G400 32MB','<strong>Dramatically Different High Performance Graphics</strong><br /><br />Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry''s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC''s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br /><br /><strong>Key features:</strong><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>','www.matrox.com/mga/products/mill_g400/home.htm',0); 
INSERT INTO products_description VALUES (3,1,'Microsoft IntelliMouse Pro','Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft''s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.','www.microsoft.com/hardware/mouse/intellimouse.asp',0); 
INSERT INTO products_description VALUES (4,1,'The Replacement Killers','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />Languages: English, Deutsch.<br />Subtitles: English, Deutsch, Spanish.<br />Audio: Dolby Surround 5.1.<br />Picture Format: 16:9 Wide-Screen.<br />Length: (approx) 80 minutes.<br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.replacement-killers.com',0); 
INSERT INTO products_description VALUES (5,1,'Blade Runner - Director''s Cut','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br />Languages: English, Deutsch.<br />Subtitles: English, Deutsch, Spanish.<br />Audio: Dolby Surround 5.1.<br />Picture Format: 16:9 Wide-Screen.<br />Length: (approx) 112 minutes.<br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.bladerunner.com',0); 
INSERT INTO products_description VALUES (6,1,'The Matrix','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch.\r<br />\nAudio: Dolby Surround.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 131 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Making Of.','www.thematrix.com',0); 
INSERT INTO products_description VALUES (7,1,'You''ve Got Mail','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch, Spanish.\r<br />\nSubtitles: English, Deutsch, Spanish, French, Nordic, Polish.\r<br />\nAudio: Dolby Digital 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 115 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.youvegotmail.com',0); 
INSERT INTO products_description VALUES (8,1,'A Bug''s Life','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Digital 5.1 / Dobly Surround Stereo.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 91 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.abugslife.com',0); 
INSERT INTO products_description VALUES (9,1,'Under Siege','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (10,1,'Under Siege 2 - Dark Territory','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (11,1,'Fire Down Below','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 100 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (12,1,'Die Hard With A Vengeance','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 122 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (13,1,'Lethal Weapon','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 100 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (14,1,'Red Corner','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 117 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (15,1,'Frantic','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 115 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (16,1,'Courage Under Fire','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 112 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (17,1,'Speed','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 112 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (18,1,'Speed 2: Cruise Control','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 120 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (19,1,'There''s Something About Mary','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 114 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (20,1,'Beloved','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 164 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).',NULL,0); 
INSERT INTO products_description VALUES (21,1,'SWAT 3: Close Quarters Battle','<strong>Windows 95/98</strong><br /><br />211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!','www.swat3.com',0); 
INSERT INTO products_description VALUES (22,1,'Unreal Tournament','From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br /><br />This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It''s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of ''bots'' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.','www.unrealtournament.net',0); 
INSERT INTO products_description VALUES (23,1,'The Wheel Of Time','The world in which The Wheel of Time takes place is lifted directly out of Jordan''s pages; it''s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you''re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter''angreal, Portal Stones, and the Ways. However you move around, though, you''ll quickly discover that means of locomotion can easily become the least of the your worries...<br /><br />During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time''s main characters. Some of these places are ripped directly from the pages of Jordan''s books, made flesh with Legend''s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you''ll have this year.','www.wheeloftime.com',0); 
INSERT INTO products_description VALUES (24,1,'Disciples: Sacred Lands','A new age is dawning...<br /><br />Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br /><br />The day of reckoning has come... and only the chosen will survive.',NULL,0); 
INSERT INTO products_description VALUES (25,1,'Microsoft Internet Keyboard PS/2','The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!',NULL,0); 
INSERT INTO products_description VALUES (26,1,'Microsoft IntelliMouse Explorer','Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!','www.microsoft.com/hardware/mouse/explorer.asp',0); 
INSERT INTO products_description VALUES (27,1,'Hewlett Packard LaserJet 1100Xi','HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP''s Resolution Enhancement technology (REt) makes every document more professional.<br /><br />Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br /><br />HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).','www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100',1); 
INSERT INTO products_description VALUES (28,1,'Samsung Galaxy Tab','<p>Powered by a Cortex A8 1.0GHz application processor, the Samsung GALAXY Tab is designed to deliver high performance whenever and wherever you are. At the same time, HD video contents are supported by a wide range of multimedia formats (DivX, XviD, MPEG4, H.263, H.264 and more), which maximizes the joy of entertainment.</p><p>With 3G HSPA connectivity, 802.11n Wi-Fi, and Bluetooth 3.0, the Samsung GALAXY Tab enhances users'' mobile communication on a whole new level. Video conferencing and push email on the large 7-inch display make communication more smooth and efficient. For voice telephony, the Samsung GALAXY Tab turns out to be a perfect speakerphone on the desk, or a mobile phone on the move via Bluetooth headset.</p>','http://galaxytab.samsungmobile.com',0);
COMMIT;

DROP TABLE products_to_categories;
CREATE TABLE products_to_categories (
  products_id number(11) NOT NULL,
  categories_id number(11) NOT NULL
);

INSERT INTO products_to_categories VALUES (1,4); 
INSERT INTO products_to_categories VALUES (2,4); 
INSERT INTO products_to_categories VALUES (3,9); 
INSERT INTO products_to_categories VALUES (4,10); 
INSERT INTO products_to_categories VALUES (5,11); 
INSERT INTO products_to_categories VALUES (6,10); 
INSERT INTO products_to_categories VALUES (7,12); 
INSERT INTO products_to_categories VALUES (8,13); 
INSERT INTO products_to_categories VALUES (9,10); 
INSERT INTO products_to_categories VALUES (10,10); 
INSERT INTO products_to_categories VALUES (11,10); 
INSERT INTO products_to_categories VALUES (12,10); 
INSERT INTO products_to_categories VALUES (13,10); 
INSERT INTO products_to_categories VALUES (14,15); 
INSERT INTO products_to_categories VALUES (15,14); 
INSERT INTO products_to_categories VALUES (16,15); 
INSERT INTO products_to_categories VALUES (17,10); 
INSERT INTO products_to_categories VALUES (18,10); 
INSERT INTO products_to_categories VALUES (19,12); 
INSERT INTO products_to_categories VALUES (20,15); 
INSERT INTO products_to_categories VALUES (21,18); 
INSERT INTO products_to_categories VALUES (22,19); 
INSERT INTO products_to_categories VALUES (23,20); 
INSERT INTO products_to_categories VALUES (24,20); 
INSERT INTO products_to_categories VALUES (25,8); 
INSERT INTO products_to_categories VALUES (26,9); 
INSERT INTO products_to_categories VALUES (27,5); 
INSERT INTO products_to_categories VALUES (28,21);
COMMIT;

DROP TABLE customers;
CREATE TABLE customers  (
  customers_id number(11) NOT NULL,
  customers_gender char(1),
  customers_firstname varchar2(255) NOT NULL,
  customers_lastname varchar2(255) NOT NULL,
  customers_email_address varchar2(255) NOT NULL,
  customers_default_address_id number(11),
  customers_telephone varchar2(255) NOT NULL,
  customers_fax varchar2(255),
  customers_password varchar2(60) NOT NULL,
  customers_newsletter char(1),
  PRIMARY KEY (customers_id)
  using index
);

INSERT INTO customers values (1,'m','Loren','Penton','loren@lorenpenton.com',1,'504.555.1212','','$P$DnvXLQR/HD129','0');
INSERT INTO customers values (2,'f','Tracy','West','tracy@tracywest.com',1,'415-555-1212','','$P$DTWnvXR/HD129','0');
INSERT INTO customers values (3,'m','Allen','Pearson','allen@allenpearson.com',1,'9415551212','','$P$DTWnLQR/HD129','0');
INSERT INTO customers values (4,'m','Steve','George','steve@stevegeorge.com',1,'4155551213','','$P$DTWnvXLQR/HD129','0');
INSERT INTO customers values (5,'m','Tom','Van Dyke','tom@tvd.com',1,'(720) 555-1212','','$P$DTWnvXLQR/HD129','0');
INSERT INTO customers values (6,'m','Mike','Papio','mikep@papio.com',1,'408-555-1212','','$P$DTWnvXLQR/HD129','0');

INSERT INTO customers values (1001,'m','Will','Poole','will@willpoole.com',1,'504.555.5555','','$P$DnvXLQR/HD129','0');
INSERT INTO customers values (1002,'f','Dena','Butler','dena@denabutler.com',1,'504-555-3333','','$P$DTWnvXR/HD129','0');
INSERT INTO customers values (1003,'m','Sergi','Jimenez','sergio@sergiojimenez.com',1,'8888888888','','$P$DTWnLQR/HD129','0');
INSERT INTO customers values (1004,'m','Mike','Effemeyer','mike@effemeyer.com',1,'4155562626','','$P$DTWnvXLQR/HD129','0');
INSERT INTO customers values (1005,'m','Richard','Head','richard@rhead.com',1,'(720) 277-5555','','$P$DTWnvXLQR/HD129','0');
INSERT INTO customers values (1006,'m','Charles','Prince','chuck@kingme.com',1,'408-676-4444','','$P$DTWnvXLQR/HD129','0');
COMMIT;

DROP TABLE customers_info;
CREATE TABLE customers_info  (
  customers_info_id number(11) NOT NULL,
  customers_info_last_logon timestamp,
  customers_info_number_logons number(5),
  customers_info_created_ts timestamp,
  customers_info_last_modified timestamp,
  global_product_notifications number(1),
  PRIMARY KEY (customers_info_id)
  using index
);

INSERT INTO customers_info VALUES (1,NULL,0,timestamp'2011-04-04 09:43:01',NULL,0);
INSERT INTO customers_info VALUES (2,NULL,0,timestamp'2011-04-04 10:13:10',NULL,0);
INSERT INTO customers_info VALUES (3,NULL,0,timestamp'2011-04-05 04:23:27',NULL,0);
INSERT INTO customers_info VALUES (4,NULL,0,timestamp'2011-04-01 08:01:32',NULL,0);
INSERT INTO customers_info VALUES (5,NULL,0,timestamp'2011-04-06 09:43:00',NULL,0);
INSERT INTO customers_info VALUES (6,NULL,0,timestamp'2011-04-06 09:43:00',NULL,0);
INSERT INTO customers_info VALUES (1001,NULL,0,timestamp'2011-04-04 09:43:01',NULL,0);
INSERT INTO customers_info VALUES (1002,NULL,0,timestamp'2011-04-04 10:13:10',NULL,0);
INSERT INTO customers_info VALUES (1003,NULL,0,timestamp'2011-04-05 04:23:27',NULL,0);
INSERT INTO customers_info VALUES (1004,NULL,0,timestamp'2011-04-01 08:01:32',NULL,0);
INSERT INTO customers_info VALUES (1005,NULL,0,timestamp'2011-04-06 09:43:00',NULL,0);
INSERT INTO customers_info VALUES (1006,NULL,0,timestamp'2011-04-06 09:43:00',NULL,0);
COMMIT;

DROP TABLE orders;
CREATE TABLE orders  (
  orders_id number(11) NOT NULL,
  customers_id number(11) NOT NULL,
  customers_name varchar2(255) NOT NULL,
  customers_company varchar2(255),
  customers_street_address varchar2(255) NOT NULL,
  customers_suburb varchar2(255),
  customers_city varchar2(255) NOT NULL,
  customers_postcode varchar2(255) NOT NULL,
  customers_state varchar2(255),
  customers_country varchar2(255) NOT NULL,
  customers_telephone varchar2(255) NOT NULL,
  customers_email_address varchar2(255) NOT NULL,
  customers_address_format_id number(5) NOT NULL,
  delivery_name varchar2(255) NOT NULL,
  delivery_company varchar2(255),
  delivery_street_address varchar2(255) NOT NULL,
  delivery_suburb varchar2(255),
  delivery_city varchar2(255) NOT NULL,
  delivery_postcode varchar2(255) NOT NULL,
  delivery_state varchar2(255),
  delivery_country varchar2(255) NOT NULL,
  delivery_address_format_id number(5) NOT NULL,
  billing_name varchar2(255) NOT NULL,
  billing_company varchar2(255),
  billing_street_address varchar2(255) NOT NULL,
  billing_suburb varchar2(255),
  billing_city varchar2(255) NOT NULL,
  billing_postcode varchar2(255) NOT NULL,
  billing_state varchar2(255),
  billing_country varchar2(255) NOT NULL,
  billing_address_format_id number(5) NOT NULL,
  payment_method varchar2(255) NOT NULL,
  cc_type varchar2(20),
  cc_owner varchar2(255),
  cc_number varchar2(32),
  cc_expires varchar2(4),
  last_modified timestamp,
  date_purchased timestamp,
  orders_status number(5) NOT NULL,
  orders_date_finished timestamp,
  currency char(3),
  currency_value number(14,6),
  PRIMARY KEY (orders_id)
  using index
);

INSERT INTO orders VALUES (1,1,'Loren Penton','','3820 Burgundy St','','New Orleans','70117','Louisiana','United States','5045551212','loren@lorenpenton.com',2,'Loren Penton','','3820 Burgundy St','','New Orleans','70117','Louisiana','United States',2,'Loren Penton','','3820 Burgundy St','','New Orleans','70117','Louisiana','United States',2,'Cash on Delivery','','','','',NULL,timestamp'2011-04-04 09:43:36',1,NULL,'USD','1.000000');
COMMIT;

DROP TABLE orders_products;
CREATE TABLE orders_products  (
  orders_products_id number(11) NOT NULL,
  orders_id number(11) NOT NULL,
  products_id number(11) NOT NULL,
  products_model varchar2(12),
  products_name varchar2(64) NOT NULL,
  products_price number(15,4) NOT NULL,
  final_price number(15,4) NOT NULL,
  products_tax number(7,4) NOT NULL,
  products_quantity number(2) NOT NULL,
  PRIMARY KEY (orders_products_id)
  using index
);

INSERT INTO orders_products VALUES (1,1,27,'HPLJ1100XI','Hewlett Packard LaserJet 1100Xi','499.9900','499.9900','0.0000',1);
COMMIT;

DROP TABLE orders_status_history;
CREATE TABLE orders_status_history  (
  orders_status_history_id number(11) NOT NULL,
  orders_id number(11) NOT NULL,
  orders_status number(5) NOT NULL,
  date_added timestamp NOT NULL,
  customer_notified number(1),
  comments varchar2(4000),
  PRIMARY KEY (orders_status_history_id, orders_id, date_added)
  using index
);

INSERT INTO orders_status_history VALUES (1,1,1,timestamp'2011-04-04 09:43:36',1,'');
INSERT INTO orders_status_history VALUES (2,1,3,timestamp'2011-04-04 14:27:18',1,'Shipped FedEx, Tracking Number: F196538W2');
COMMIT;

DROP TABLE orders_total;
CREATE TABLE orders_total  (
  orders_total_id number(10) NOT NULL,
  orders_id number(11) NOT NULL,
  title varchar2(255) NOT NULL,
  text varchar2(255) NOT NULL,
  orders_value number(15,4) NOT NULL,
  class varchar2(32) NOT NULL,
  sort_order number(11) NOT NULL,
  PRIMARY KEY (orders_total_id)
  using index
);

INSERT INTO orders_total VALUES (1,1,'Sub-Total:','$499.99','499.9900','ot_subtotal',1);
INSERT INTO orders_total VALUES (2,1,'Flat Rate (Best Way):','$5.00','5.0000','ot_shipping',2);
INSERT INTO orders_total VALUES (3,1,'Total:','<strong>$504.99</strong>','504.9900','ot_total',4);
COMMIT;

DROP TABLE next_cust;
CREATE TABLE next_cust (
 customers_id number(11) NOT NULL,
  primary key (customers_id)
  using index
);

INSERT INTO next_cust values (7);
COMMIT;

DROP TABLE next_order;
CREATE TABLE next_order  (
  orders_id number(11) NOT NULL,
  primary key (orders_id)
  using index
);

INSERT INTO next_order values (2);
COMMIT;

DROP TABLE customers_lkup;
CREATE TABLE customers_lkup  (
  lkup_id number(11),
  customers_gender char(1),
  customers_firstname varchar2(255) NOT NULL,
  customers_lastname varchar2(255) NOT NULL,
  customers_street varchar2(50) NOT NULL,
  customers_city varchar2(50) NOT NULL,
  customers_state char (2) NOT NULL,
  PRIMARY KEY (lkup_id)
  using index
);

INSERT INTO customers_lkup values (1,'m','Joe','Pulic','Main St','Anytown','ME');
INSERT INTO customers_lkup values (2,'f','Jane','Pulic','Main Ave','Dubuque','IA');
INSERT INTO customers_lkup values (3,'m','John','Doe','Rodent Blvd','Hamsterville','CA');
INSERT INTO customers_lkup values (4,'f','Mary','Doe','Arsenio Way','Hall','GA');
INSERT INTO customers_lkup values (5,'m','Paul','Harvey','Pirates Alley','Bayou Lafourche','LA');
INSERT INTO customers_lkup values (6,'f','George','Harrison','Abbey Rd','Beetle','TX');
INSERT INTO customers_lkup values (7,'m','Ringo','Starr','Stick Ave','Drummen','SD');
INSERT INTO customers_lkup values (8,'f','Max','Dog','Purina Ct','Denver','CO');
INSERT INTO customers_lkup values (9,'m','Alice','Lookinglass','White Rabbit Ct','Golden','CO');
INSERT INTO customers_lkup values (10,'f','Betty','Davis','Massachussets St','Warren','MA');
INSERT INTO customers_lkup values (11,'m','Shawanda','Jones','Terpsichore St','New Orleans','LA');
INSERT INTO customers_lkup values (12,'f','Raymond','Johnson','Crescent Ave','Cantonement','FL');
INSERT INTO customers_lkup values (13,'m','Cecelia','Jeanseanne','Bingham Way','Milton','FL');
INSERT INTO customers_lkup values (14,'f','Ann','Rice','Bloodsucker Blvd','Bon Temps','LA');
INSERT INTO customers_lkup values (15,'m','Carl','Dugas', 'W 33rd St','New York','NY');
INSERT INTO customers_lkup values (16,'f','Justine','Notimberlake','Camino de Real','Silver Lake','CA');
INSERT INTO customers_lkup values (17,'m','Darryl','Hannah','Jonsen St','Buffallo','NY');
INSERT INTO customers_lkup values (18,'f','Hannah','BigSky','Mort Way','Mindy','AZ');
INSERT INTO customers_lkup values (19,'m','Bernie','Bigmack','Pico de Gallo','Phoenix','AZ');
INSERT INTO customers_lkup values (20,'f','Bernice','Litlmac','Vegas Blvd','Las Vegas','NV');
INSERT INTO customers_lkup values (21,'m','Harvey','Rabbit','Second Ave NW','Portland','OR');
INSERT INTO customers_lkup values (22,'f','Julie','Haggerty','Machu Pichu Blvd','Seattle','WA');
INSERT INTO customers_lkup values (23,'m','Ivan','Da Terrible','Rome St','Moscow','GA');
INSERT INTO customers_lkup values (24,'f','Yvonne','Goldenrod','Hermindger Ave','Metairie','LA');
INSERT INTO customers_lkup values (25,'m','Aaaron','Marmonsky','Yugho St','Hudson','NY');
INSERT INTO customers_lkup values (26,'f','Charmaine','Neville','France St','Bywater','LA');
INSERT INTO customers_lkup values (27,'m','Michael','Doucette','Cajun Conga Blvd','Lafitte','LA');
INSERT INTO customers_lkup values (28,'f','Pinky','Tuscadero','Packer Blvd','Milwaukee','WI');
INSERT INTO customers_lkup values (29,'m','Scott','Paulie','Hollywood Blvd','Hollywood','CA');
INSERT INTO customers_lkup values (30,'f','Gina','Fallopia','Marmout Ave','Columbus','OH');
INSERT INTO customers_lkup values (31,'m','Obtuse','Morethninety','Mathematics CT','Arlington','VA');
INSERT INTO customers_lkup values (32,'f','Amanta','Reconwidth','Dudely Ct','Gadsen','UT');
INSERT INTO customers_lkup values (33,'m','Nolegs','Knealing','Broken Knee Rd','Custer','SD');
INSERT INTO customers_lkup values (34,'f','Nelly','Woa','Mustang St','Ft Worth','TX');
INSERT INTO customers_lkup values (35,'m','Upson','Downs','Upson St','Derrier','NH');
INSERT INTO customers_lkup values (36,'f','Pepper','Mache','Peachtree St','Atlanta','GA');
COMMIT;


EXIT;
/
