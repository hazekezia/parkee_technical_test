import pandas as pd

branch_a = pd.read_csv('branch_a.csv')
branch_b = pd.read_csv('branch_b.csv')
branch_c = pd.read_csv('branch_c.csv')

all_data = pd.concat([branch_a, branch_b, branch_c], ignore_index=True)

#Hapus baris yang memiliki nilai NaN pada kolom transaction_id, date, dan customer_id
all_data.dropna(subset=['transaction_id', 'date', 'customer_id'], inplace=True)

#Ubah format kolom date menjadi tipe datetime
all_data['date'] = pd.to_datetime(all_data['date'])

#Hilangkan duplikat berdasarkan transaction_id, pilih data berdasarkan date terbaru
all_data.sort_values('date', inplace=True)
all_data.drop_duplicates(subset='transaction_id', keep='last', inplace=True)

#Menghitung total penjualan per cabang
all_data['total'] = all_data['quantity'] * all_data['price']
total_sales_per_branch = all_data.groupby('branch')['total'].sum().reset_index()

#Menyimpan hasilnya ke file baru total_sales_per_branch.csv
total_sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)

print("Proses selesai. File 'total_sales_per_branch.csv' telah dibuat.")