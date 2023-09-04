alter table KetQua add check (DiemLan1>=0 and DiemLan1<=10 and DiemLan2>=0 and DiemLan2<=10)



alter table SinhVien add constraint DienThoai check (len(DienThoai) between  10 and 11)

alter table SinhVien add SoCMND varchar(20)
alter table SinhVien add constraint CMND_duynhat unique(SoCMND)
alter table SinhVien add constraint NgaySinh check ((year(getdate())-year(NgaySinh))>=18)

alter table Lop drop constraint FK_Lop_khoa
--alter table SinhVien add constraint CMND



---------------IV----------------------


select sv.MaSV, sv.HoDem, sv.Ten, hp.TenHP, kq.DiemLan1, 
case
	when DiemLan1>=5 then N'Đạt'
	else  N'Không Đạt'

end as 'KetQua'
from SinhVien sv, HocPhan hp, KetQua kq
where sv.MaSV=kq.MaSV and kq.MaHP= hp.MaHP 
order by sv.MaSV



select sv.MaLop, sv.MaSV, sv.HoDem, sv.Ten, hp.TenHP,
case 
	when DiemLan1>=5 then DiemLan1
	when DiemLan2 is NULL then 0
	else 
		case when DiemLan1>DiemLan2 then DiemLan1
			else DiemLan2
			end 
end as 'DiemKQ'
from SinhVien sv, HocPhan hp, KetQua kq
where sv.MaSV=kq.MaSV and kq.MaHP= hp.MaHP 








select sv.MaSV, sv.HoDem, sv.Ten, Round(Avg(IIF([diemlan1]>ISNULL([diemlan2],0),[diemlan1],[diemlan2])),1) as 'DiemTB',
case 
	when Round(Avg(IIF([diemlan1]>ISNULL([diemlan2],0),[diemlan1],[diemlan2])),1)>=8 then 'Giỏi'
	 when Round(Avg(IIF([diemlan1]>ISNULL([diemlan2],0),[diemlan1],[diemlan2])),1)>=6.5 then 'Khá'
	 when Round(Avg(IIF([diemlan1]>ISNULL([diemlan2],0),[diemlan1],[diemlan2])),1)>=5 then 'TB'
	else 'Yếu'
end as 'XepLoai'
from SinhVien sv, HocPhan hp, KetQua kq
where sv.MaSV=kq.MaSV and kq.MaHP= hp.MaHP 
group by  sv.MaSV, sv.HoDem, sv.Ten








 


 -----------------------------------------





 ----A---
 create view cauA as
 select sv.MaSV, sv.HoDem, sv.Ten, TenHP, DiemLan1, DiemLan2
 from SinhVien sv, KetQua kq, HocPhan hp
 where sv.MaSV=kq.MaSV and kq.MaHP= hp.MaHP 


 ---B---
 create view cauB as
 select sv.MaSV, sv.HoDem, sv.Ten, kq.MaHP, hp.TenHP, kq.DiemLan1, kq.DiemLan2
  from SinhVien sv, KetQua kq, HocPhan hp
 where sv.MaSV=kq.MaSV and kq.MaHP= hp.MaHP and
 sv.MaLop like '_TH%'
  and kq.DiemLan2 is not NULL

  ---C---

	create view cauC as
	select sv.MaSV, sv.HoDem, sv.Ten, kq.MaHP, hp.TenHP, kq.DiemLan1, kq.DiemLan2
	from SinhVien sv, KetQua kq, HocPhan hp
	where sv.MaSV=kq.MaSV and kq.MaHP= hp.MaHP

	---D---
	create view cauD as
	select sv.MaSV, sv.HoDem, sv.Ten, kq.MaHP, hp.TenHP, kq.DiemLan1, kq.DiemLan2
	from SinhVien sv, KetQua kq, HocPhan hp
	where sv.MaSV=kq.MaSV and kq.MaHP= hp.MaHP and DiemLan2 is NULL

