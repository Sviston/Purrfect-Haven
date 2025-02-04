using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace PurrfectHaven
{
    public partial class Form1 : Form
    {
        string ConnectionString = "Server=localhost;Port=3306;Database=purrfecthaven;Uid=root;Pwd=hentai2021;";

        List<Animal> animals = new List<Animal>();
        List<string> SpeciesNames = new List<string>();

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            comboBox1.SelectedItem = "All";
            comboBox3.SelectedItem = "Doesn't matter";

            // Add Species Names
            var con = new MySqlConnection(ConnectionString);
            con.Open();
            string Query = "SELECT * FROM Species";
            var cmd = new MySqlCommand(Query, con);
            var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                SpeciesNames.Add(reader.GetString("Name"));
                listBox1.Items.Add(SpeciesNames[SpeciesNames.Count-1]);
            }
            con.Close();
            
            // Add cities
            comboBox2.Items.Add("All");
            comboBox2.SelectedItem = "All";
            con.Open();
            Query = "SELECT City FROM havens GROUP BY City";
            cmd = new MySqlCommand(Query, con);
            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                comboBox2.Items.Add(reader.GetString("City"));
            }
            con.Close();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(textBox1.Text, "[^0-9]"))
            {
                MessageBox.Show("Please enter only numbers.");
                textBox1.Text = "";
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(textBox2.Text, "[^0-9]"))
            {
                MessageBox.Show("Please enter only numbers.");
                textBox2.Text = "";
            }
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            var listItems = listBox1.SelectedItems;
            listBox2.Items.Clear();
            var con = new MySqlConnection(ConnectionString);
            con.Open();
            string Query = "SELECT b.Name FROM breeds b JOIN species s ON s.id = b.Species_Id WHERE 1=0";
            for (int i = 0; i < listItems.Count; i++) 
            {
                Query += " or s.Name = '" + listItems[i] + "'";
            }
            var cmd = new MySqlCommand(Query, con);
            var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                listBox2.Items.Add(reader.GetString("Name"));
            }
            con.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            panel1.Controls.Clear();
            animals = new List<Animal>();
            // check age

            if (textBox1.Text != "" && textBox2.Text != "")
            {
                if (Int32.Parse(textBox1.Text) > Int32.Parse(textBox2.Text)) 
                {
                    MessageBox.Show("Min age must be not greater than max age!");
                    return;        
                }
            }
            // make quiery and get
            var con = new MySqlConnection(ConnectionString);
            con.Open();
            string Query = "SELECT TIMESTAMPDIFF(Month, a.Date_Of_Birth, CURDATE()) as Age, IFNULL(Disability, \"None\") as Disab, IFNULL(DATE_FORMAT(Euthanized, '%d-%m-%Y'), \"No\") as Eut, a.*,b.*,s.*,h.*, a.Name as AName, b.Name as BName, s.Name as SName, h.Name as HName ";
            Query += "FROM Animals a JOIN Breeds b ON a.breed_id = b.id JOIN Species s ON s.id = b.species_id JOIN Havens h ON h.id = a.haven_id WHERE 1=1";
            // add all checks!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            if (listBox2.SelectedItems.Count > 0) 
            {
                var list = listBox2.SelectedItems;
                string sq = "(1=0";
                for (int i = 0; i < list.Count; i++)
                {
                    sq += " or b.Name = '" + list[i] + "'";
                }
                sq += ")";
                Query += " and " + sq;
            }
            else if (listBox1.SelectedItems.Count > 0)
            {
                var list = listBox1.SelectedItems;
                string sq = "(1=0";
                for (int i = 0; i < list.Count; i++)
                {
                    sq += " or s.Name = '" + list[i] + "'";
                }
                sq += ")";
                Query += " and " + sq;
            }
            if(textBox1.Text != null && textBox1.Text != "")
            {
                Query += " and TIMESTAMPDIFF(Month, a.Date_Of_Birth, CURDATE()) >= " + textBox1.Text;
            }
            if (textBox2.Text != null && textBox2.Text != "")
            {
                Query += " and TIMESTAMPDIFF(Month, a.Date_Of_Birth, CURDATE()) <= " + textBox2.Text;
            }
            if (comboBox1.SelectedItem.ToString() == "Male")
            {
                Query += " and Gender = 'Male'";
            }
            else if (comboBox1.SelectedItem.ToString() == "Female")
            {
                Query += " and Gender = 'Female'";
            }
            if (comboBox2.SelectedItem.ToString() != "All")
            {
                Query += " and City = '" + comboBox2.SelectedItem.ToString() + "'";
            }
            if (comboBox3.SelectedItem.ToString() == "Without")
            {
                Query += " and Disability is null";
            }
            else if (comboBox3.SelectedItem.ToString() == "Only with")
            {
                Query += " and Disability is not null";
            }
            if (checkBox2.Checked == true)
            {
                Query += " and Euthanized is not Null";
            }
            var cmd = new MySqlCommand(Query, con);
            var reader = cmd.ExecuteReader();
            int position = 25;
            while (reader.Read())
            {
                string PhotoPath = reader.GetString("Photo");
                PhotoPath = PhotoPath.Replace("/", "\\");
                PhotoPath = "..\\.." + PhotoPath;
                if (!File.Exists(PhotoPath))
                {
                    PhotoPath = "..\\..\\Photos\\universal.jpg";
                }
                //parsing data
                string AnimalName = reader.GetString("AName");
                string Breed = reader.GetString("BName");
                string Specie = reader.GetString("SName");
                int Age = reader.GetInt32("Age");
                string City = reader.GetString("City");
                string Gender = reader.GetString("Gender");
                string Disability = reader.GetString("Disab");
                string Euthanasia = reader.GetString("Eut");
                string Description = reader.GetString("Description");
                string Haven = reader.GetString("HName");
                string Size = reader.GetString("Size");
                string Mass = reader.GetFloat("Mass").ToString();
                string Website = reader.GetString("Website");
                string Email = reader.GetString("Email");
                string Phone = reader.GetString("Phone_Number");
                string Address = reader.GetString("Address");

                string Text = AnimalName;
                Text += ", " + Breed + " " + Specie + ".";
                if (Age >= 12)
                {
                    if (Age / 12 > 1) Text += " " + Age/12 + " years";
                    else Text += " " + Age / 12 + " year";
                }
                if (Age%12 > 0)
                {
                    if (Age%12 > 1) Text += " and " + Age % 12 + " months.";
                    else Text += " and " + Age % 12 + " month.";
                }
                Text += "\r\n";
                Text += "\r\nSize: " + Size + ", Mass: " + Mass + ". " + Gender + ".";
                Text += "\r\nDisability: " + Disability + ", Planned for Euthanasia: " + Euthanasia + ".";
                Text += "\r\nCity: " + City + ".";
                Text += "\r\n";
                Text += "\r\n" + Description;
                Text += "\r\n";
                Text += "\r\n" + Haven + ", " + Address;
                Text += "\r\nWebsite: " + Website;
                Text += "\r\nEmail: " + Email;
                Text += "\r\nPhone: " + Phone;

                Animal animal = new Animal();
                animal.pictureBox = new PictureBox();
                animal.pictureBox.Location = new Point(25, position);
                animal.pictureBox.Size = new Size(450,450);
                animal.pictureBox.Image = Image.FromFile(PhotoPath);
                panel1.Controls.Add(animal.pictureBox);
                position += 460;

                animal.label = new System.Windows.Forms.TextBox();
                animal.label.Location = new Point(25, position);
                animal.label.MaximumSize = new Size(450, 0);
                animal.label.AutoSize = true;
                animal.label.Text = Text;
                animal.label.Font = label1.Font;
                animal.label.ReadOnly = true;
                animal.label.BorderStyle = 0;
                animal.label.BackColor = panel1.BackColor;
                animal.label.TabStop = false;
                animal.label.Multiline = true;
                animal.label.WordWrap = true;
                Size size = TextRenderer.MeasureText(animal.label.Text, animal.label.Font, animal.label.MaximumSize, TextFormatFlags.WordBreak);
                animal.label.Width = size.Width;
                animal.label.Height = size.Height;
                panel1.Controls.Add(animal.label);
                position += animal.label.Height + 25;

                animals.Add(animal);
            }
            con.Close();
            // parse to text
            // add them to panel
        }
    }
    public class Animal
    {
        public PictureBox pictureBox;
        public System.Windows.Forms.TextBox label;
    }
}
