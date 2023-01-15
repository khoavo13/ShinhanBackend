### MỘT SỐ TÁC DỤNG CƠ BẢN
- Hibernate làm việc thực sự, nó mapping giữa Java và Database nhưng dựa vào nguyên tắc mapping của JPA.
- Spring Data JPA giúp 1 số công việc nhẹ nhàng hơn, tránh lặp lại code thừa thải (do 1 entity có nhiều phương thức, câu lệnh lặp lại), cung cấp một số phương thức để đỡ viết code ở tầng Repository và hỗ trợ viết CRUD dễ dàng hơn. Spring Data JPA hỗ trợ triển khai, lúc mà build tạo ra triển khai interface, lúc đó mới code SQL được.

### SPRING DATA WORK FLOW
![Tên ảnh] (https://camo.githubusercontent.com/5f7f4e17d36ee314c99bd9d70ff3a9506befdddd1c4a1395c4f7bd97394b6db6/68747470733a2f2f74657261736f6c756e616f72672e6769746875622e696f2f67756964656c696e652f352e312e302e52454c454153452f656e2f5f696d616765732f646174616163636573735f6a70612e706e67)

1.Gọi phương thức của Repository interface. Entity object, Entity ID, … được truyền dưới dạng tham số gọi phương thức. Các thực thể được thông qua cũng có thể là một giá trị nguyên thủy. 

2. Proxy class thực hiện động Repository interface ủy quyền xử lý đến org.springframework.data.jpa.repository.support.simplejparepository và custom Repository class. Các tham số được chỉ định bởi Service được truyền vào. 

3. Repository implementation class gọi API JPA. Các tham số được chỉ định bởi Service và các tham số được tạo bởi Repository implementation class được truyền vào. 

4. Hibernate JPA tham khảo triển khai gọi operations trong Hibernate core APIs. Các tham số được chỉ định từ Repository implementation class và các tham số được tạo bởi Hibernate JPA được truyền vào.

5. Hibernate Core APIs sẽ tạo ra các câu lệnh SQL và liên kết từ các tham số được chỉ định và chuyển chúng cho JDBC driver. 

6. JDBC driver thực hiện SQL bằng cách gửi các giá trị SQL và liên kết đã truyền vào cơ sở dữ liệu.
