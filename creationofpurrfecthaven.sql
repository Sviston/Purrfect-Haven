CREATE TABLE Species (
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Breeds (
    Id INT PRIMARY KEY,
    Species_Id INT,
    Name VARCHAR(255) NOT NULL,
    FOREIGN KEY (Species_Id) REFERENCES Species(Id)
);

CREATE TABLE Havens (
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Phone_Number VARCHAR(20),
    Email VARCHAR(255),
    Website VARCHAR(255)
);

CREATE TABLE Users (
    Id INT PRIMARY KEY,
    Login VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone_Number VARCHAR(20),
    Name VARCHAR(255) NOT NULL,
    Surname VARCHAR(255) NOT NULL
);

CREATE TABLE Animals (
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Breed_Id INT,
    Description VARCHAR(500),
    Date_Of_Birth DATE,
    Gender VARCHAR(10) NOT NULL,
    Arrival_Date DATE NOT NULL,
    Euthanized DATE NULL,
    Haven_Id INT,
    Size VARCHAR(50),
    Mass FLOAT(2),
    Disability VARCHAR(255) NULL,
    Photo VARCHAR(255),
    FOREIGN KEY (Breed_Id) REFERENCES Breeds(Id),
    FOREIGN KEY (Haven_Id) REFERENCES Havens(Id)
);

CREATE TABLE Adoptions (
    Id INT PRIMARY KEY,
    User_Id INT,
    Animal_Id INT UNIQUE,
    Status VARCHAR(50),
    Begin_Date DATE NOT NULL,
    Adoption_Date DATE NULL,
    Last_Change_Status DATE,
    End_Date DATE,
    FOREIGN KEY (User_Id) REFERENCES Users(Id),
    FOREIGN KEY (Animal_Id) REFERENCES Animals(Id)
);

INSERT INTO Species (Id, Name) VALUES 
(1, 'Dog'),
(2, 'Cat'),
(3, 'Rabbit'),
(4, 'Bird'),
(5, 'Hamster'),
(6, 'Ferret');

INSERT INTO Breeds (Id, Species_Id, Name) VALUES 
(1, 1, 'Golden Retriever'),
(2, 1, 'Bulldog'),
(3, 1, 'Poodle'),
(4, 2, 'Siamese'),
(5, 2, 'Persian'),
(6, 2, 'Maine Coon'),
(7, 3, 'Holland Lop'),
(8, 3, 'Mini Rex'),
(9, 4, 'Parrot'),
(10, 4, 'Canary'),
(11, 5, 'Syrian'),
(12, 5, 'Dwarf'),
(13, 6, 'Standard Ferret'),
(14, 6, 'Angora Ferret');

INSERT INTO Havens (Id, Name, City, Address, Phone_Number, Email, Website) VALUES 
(1, 'Happy Paws Haven', 'Warsaw', '123 Animal St.', '22-555-1234', 'contact@happypaws.pl', 'www.happypaws.pl'),
(2, 'Safe Haven Shelter', 'Krakow', '456 Pet Ave.', '12-555-5678', 'info@safehaven.pl', 'www.safehaven.pl'),
(3, 'Animal Friends Center', 'Gdansk', '789 Pet St.', '58-555-9999', 'info@animalfriends.pl', 'www.animalfriends.pl');

INSERT INTO Users (Id, Login, Password, Email, Phone_Number, Name, Surname) VALUES 
(1, 'john_doe', 'password123', 'john@example.pl', '22-555-9999', 'John', 'Doe'),
(2, 'jane_smith', 'securePass', 'jane@example.pl', '12-555-8888', 'Jane', 'Smith'),
(3, 'alice_w', 'alicePass', 'alice@example.pl', '58-555-7777', 'Alice', 'Williams'),
(4, 'bob_k', 'bob123', 'bob@example.pl', '22-555-6666', 'Bob', 'Keller');

INSERT INTO Animals (Id, Name, Breed_Id, Description, Date_Of_Birth, Gender, Arrival_Date, Euthanized, Haven_Id, Size, Mass, Disability, Photo) VALUES 
(1, 'Buddy', 1, 'Buddy is a golden-coated Golden Retriever with a cheerful and outgoing personality. He loves to play fetch and thrives on human interaction. Known for his loyalty and gentle nature, Buddy is fantastic with children and other pets. His calm nature also makes him a great companion for older individuals. When not playing, he loves to relax at his owner’s feet.', '2020-04-10', 'Male', '2023-10-01', NULL, 1, 'Large', 30.0, NULL, '/photos/buddy.jpg'),

(2, 'Max', 2, 'Max is a stout, muscular Bulldog with a wrinkled face and calm demeanor. Despite his arthritis, he enjoys short walks and is very affectionate. Max is known to form strong bonds with his caregivers and loves lounging by their side. His steady nature and patience make him great with children. Max prefers a relaxed lifestyle with occasional bursts of playfulness.', '2019-03-15', 'Male', '2023-09-15', NULL, 1, 'Medium', 25.0, 'Arthritis', '/photos/max.jpg'),

(3, 'Whiskers', 4, 'Whiskers is a sleek Siamese cat with striking blue eyes and a curious nature. She enjoys exploring her surroundings and is incredibly intelligent. Whiskers is highly social, often following her caregivers around for attention. With a love for play, she is always on the lookout for toys to chase. Despite her playful side, she’s also quite affectionate.', '2021-05-20', 'Female', '2023-08-20', NULL, 2, 'Small', 5.5, NULL, '/photos/whiskers.jpg'),

(4, 'Fluffy', 5, 'Fluffy is a Persian cat with a luxurious white coat and gentle personality. She is very calm and enjoys lounging in sunny spots around the house. Fluffy has a quiet nature but loves to be petted and brushed, often purring contentedly. She bonds deeply with her caregivers and appreciates a peaceful environment. Although laid-back, she’s also quite affectionate.', '2022-01-05', 'Female', '2023-07-10', NULL, 2, 'Medium', 6.0, NULL, '/photos/fluffy.jpg'),

(5, 'Bella', 3, 'Bella is a lively Poodle with a curly coat and an intelligent gaze. She is incredibly active and loves performing tricks. Bella is very friendly with people and enjoys learning new things. Her agility and energy make her great at dog sports. She is playful but also obedient, always eager to please her caregiver.', '2020-11-22', 'Female', '2023-06-15', NULL, 1, 'Small', 7.5, NULL, '/photos/bella.jpg'),

(6, 'Thumper', 7, 'Thumper is a small, soft Holland Lop rabbit with a gentle nature. He loves cuddling and sitting on laps, enjoying quiet bonding time. Thumper is curious but calm, making him a great pet for calm environments. He’s friendly towards people and isn’t easily startled. His favorite activity is munching on leafy greens.', '2022-04-08', 'Male', '2023-09-20', NULL, 3, 'Small', 2.0, NULL, '/photos/thumper.jpg'),

(7, 'Oreo', 8, 'Oreo is a Mini Rex rabbit with soft, velvety fur and a curious personality. She is very energetic and loves exploring her surroundings. Oreo enjoys gentle playtime and is quite social with people. Her petite size and lively nature make her a joy to watch. She can be shy at first but quickly warms up to friendly faces.', '2021-09-10', 'Female', '2023-05-11', NULL, 3, 'Small', 1.8, NULL, '/photos/oreo.jpg'),

(8, 'Polly', 9, 'Polly is a small, vibrant parrot known for her colorful feathers and chatty nature. She loves mimicking sounds and is quick to greet visitors. Polly is highly social and enjoys being part of daily activities. She thrives with lots of interaction and is very intelligent. Her playful side is evident as she tries to engage with anyone nearby.', '2020-03-25', 'Female', '2023-04-09', NULL, 1, 'Small', 0.1, NULL, '/photos/polly.jpg'),

(9, 'Sunny', 10, 'Sunny is a cheerful canary with bright yellow feathers and a beautiful singing voice. He spends his days singing and enjoys perching high up. Sunny is lively and loves being around people. His song brings a touch of happiness to any room. Despite his small size, he has a big personality.', '2021-06-30', 'Male', '2023-07-07', NULL, 2, 'Small', 0.09, NULL, '/photos/sunny.jpg'),

(10, 'Nibbles', 11, 'Nibbles is a playful Syrian hamster with a small, curious face. He is very active, spending hours exploring his habitat. Nibbles loves nibbling on treats and interacting with toys. His adventurous nature makes him fun to watch. Despite his small size, he has a lot of energy and personality.', '2023-02-18', 'Male', '2023-08-12', NULL, 3, 'Tiny', 0.15, NULL, '/photos/nibbles.jpg'),

(11, 'Peanut', 12, 'Peanut is a tiny, friendly dwarf hamster who loves exploring. She is inquisitive and enjoys burrowing into bedding. Peanut is gentle and enjoys being held, though she’s quite fast-moving. Her curiosity is endless, and she is always on the lookout for something new. She brings a lot of joy with her playful antics.', '2022-12-12', 'Female', '2023-09-15', NULL, 1, 'Tiny', 0.12, NULL, '/photos/peanut.jpg'),

(12, 'Shadow', 6, 'Shadow is a large, calm Maine Coon with a bushy tail and calm temperament. He is affectionate, often following his owner around the house. Shadow is gentle and loves to be groomed. Known for his loyalty, he bonds deeply with his caregivers. His laid-back nature makes him a wonderful, low-maintenance companion.', '2018-10-05', 'Male', '2023-01-25', NULL, 2, 'Large', 9.5, NULL, '/photos/shadow.jpg'),

(13, 'Lucky', 5, 'Lucky is a playful Persian with a curious nature and a fluffy coat. He is very friendly and loves human attention. Despite missing one ear, he’s energetic and doesn’t let it slow him down. Lucky enjoys lounging on soft surfaces and is incredibly affectionate. His calm demeanor makes him great for families.', '2021-02-14', 'Male', '2023-03-13', NULL, 3, 'Medium', 6.2, 'One ear missing', '/photos/lucky.jpg');

INSERT INTO Animals (Id, Name, Breed_Id, Description, Date_Of_Birth, Gender, Arrival_Date, Euthanized, Haven_Id, Size, Mass, Disability, Photo) VALUES 
(14, 'Milo', 4, 'Milo is a sleek Siamese cat with a striking coat and lively personality. He is very vocal and enjoys conversing with his caregivers. Milo is affectionate and loves to be the center of attention, often curling up on laps. His curiosity makes him a natural explorer, though he’s always cautious around new faces. He’s loyal and forms strong bonds.', '2019-07-22', 'Male', '2023-02-14', NULL, 1, 'Small', 5.4, NULL, '/photos/milo.jpg'),

(15, 'Rosie', 3, 'Rosie is a standard Poodle with a curly coat and elegant posture. She is very friendly and energetic, loving playtime and training sessions. Rosie’s intelligence shines through in her ability to learn new commands quickly. She bonds deeply with her caregiver and is protective of her family. Despite her energy, she is very gentle.', '2021-08-11', 'Female', '2023-05-20', '2025-03-30', 1, 'Medium', 20.0, 'Hip dysplasia', '/photos/rosie.jpg'),

(16, 'Coco', 11, 'Coco is a small, cheerful Syrian hamster with a brown and white coat. She is curious and loves burrowing through bedding in search of treats. Coco enjoys exploring her habitat and playing with small toys. Although timid at first, she quickly warms up to gentle handling. Her playful nature brings a lot of entertainment.', '2023-03-19', 'Female', '2023-09-30', NULL, 2, 'Tiny', 0.14, NULL, '/photos/coco.jpg'),

(17, 'Charlie', 2, 'Charlie is a sturdy Bulldog with a muscular build and a calm, composed demeanor. He is loyal and protective, often staying close to his caregiver. Charlie enjoys short walks and is very tolerant, making him great with children. His calm presence is comforting, though he can be playful at times. He prefers a quiet, stable environment.', '2019-10-15', 'Male', '2023-03-01', '2025-07-15', 3, 'Medium', 24.5, 'Arthritis', '/photos/charlie.jpg'),

(18, 'Willow', 8, 'Willow is a Mini Rex rabbit with a beautiful coat and gentle personality. She is a bit shy at first, but warms up with treats and gentle handling. Willow loves to explore and enjoys snuggling in cozy spots. Her soft fur and calm nature make her ideal for families. Willow enjoys the occasional run and is curious by nature.', '2022-01-04', 'Female', '2023-06-14', NULL, 3, 'Small', 1.7, NULL, '/photos/willow.jpg'),

(19, 'Chirpy', 9, 'Chirpy is a lively parrot with vivid feathers and a love for attention. She enjoys mimicking sounds and is quick to respond to people around her. Chirpy is highly social and loves being in the middle of activities. She’s playful and energetic, often engaging with her toys. Her cheerful chirps brighten up the room.', '2021-05-30', 'Female', '2023-07-18', NULL, 2, 'Small', 0.12, NULL, '/photos/chirpy.jpg'),

(20, 'Misty', 6, 'Misty is a gentle Maine Coon with a large frame and soft fur. She has a calm and friendly nature, often following her caregiver from room to room. Misty loves lounging in sunny spots and enjoys occasional grooming sessions. Her affectionate personality makes her great for families. Though quiet, she forms strong bonds and offers great companionship.', '2020-10-02', 'Female', '2023-01-12', NULL, 3, 'Large', 8.5, NULL, '/photos/misty.jpg');

INSERT INTO Adoptions (Id, User_Id, Animal_Id, Status, Begin_Date, Adoption_Date, Last_Change_Status, End_Date) VALUES 
(1, 1, 3, 'Completed', '2023-08-05', '2023-08-10', '2023-08-10', NULL),
(2, 2, 5, 'In Progress', '2023-09-20', NULL, '2023-09-25', NULL),
(3, 3, 6, 'Pending', '2023-10-02', NULL, '2023-10-05', NULL),
(4, 4, 8, 'Completed', '2023-07-18', '2023-07-21', '2023-07-21', NULL),
(5, 1, 10, 'In Progress', '2023-08-01', NULL, '2023-08-05', NULL),
(6, 2, 13, 'Completed', '2023-07-01', '2023-07-05', '2023-07-05', NULL),
(7, 3, 18, 'Pending', '2023-09-10', NULL, '2023-09-15', NULL),
(8, 4, 20, 'Completed', '2023-08-25', '2023-08-29', '2023-08-29', NULL);




