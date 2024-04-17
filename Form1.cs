using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using System.IO;




namespace _10_LeThanhDanh_ThucHanh3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private SqlConnection conn;
        public void connect()
        {
            string strcon = "Data Source=LAPTOP-3LK384CE\\DANH;Initial Catalog=QLHOCSINH;Integrated Security=True;Trust Server Certificate=True";
            try
            {
                conn = new SqlConnection(strcon);
                conn.Open();
                conn.Close();
            }
            catch (Exception )
            {

                MessageBox.Show("Không kết nối được CSDL", "Thông báo",
                MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        public DataTable getDSLop()
        {
            string strSQL = "Select * from Lop";
            SqlDataAdapter adapter;
            adapter = new SqlDataAdapter(strSQL, conn);
            DataSet dataset = new DataSet();
            try
            {
                adapter.Fill(dataset);
                return dataset.Tables[0];
            }
            catch
            {
                return null;
            }

        }

        string maHS, tenHS, diachi, malop;
        double dtb;
        DateTime ngaysinh;

        private void btnLuu_Click(object sender, EventArgs e)
        {
            try
            {
                maHS = txtMaHS.Text;
                tenHS = txtTenHS.Text;
                ngaysinh = dtpNgaySinh.Value; //DateTimePicker
                diachi = txtDiaChi.Text;
                malop = cmbLop.SelectedValue.ToString();
                dtb = Convert.ToDouble(txtDiemTB.Text);
            }
            catch
            {
                MessageBox.Show("Sai thong tin");
                return;
            }
            try
            {
                conn.Open();
                string str = "insert into HocSinh VALUES('" +
                maHS + "',N'" + tenHS + "','" +
                ngaysinh + "',N'" + diachi + "'," +
                dtb + ",'" + malop + "')";
                SqlCommand cmd = new SqlCommand(str, conn);

                cmd.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Thêm dữ liệu thành công");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Thêm dữ liệu bị lỗi" + ex.ToString());
            }
        }

        private void BtnXoa_Click(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                string strSQL = "delete from HocSinh where maHS ='" + maHS + "'";
                SqlCommand cmd = new SqlCommand(strSQL, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Xóa dữ liệu thành công");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Xóa bị lỗi" + ex.ToString());
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            connect();
            //Tạo 1 datatable để lấy dữ liệu từ bảng Lớp
            //qua hàm getDSLop()
            DataTable table = getDSLop();
            //Đổ dữ liệu lên combobox
            cmbLop.DataSource = table;
            //Nội dung hiển thị lên combobox
            cmbLop.DisplayMember = "TenLop";
            //giá trị truy xuất combobox
            cmbLop.ValueMember = "MaLop";
        }


    }
}
