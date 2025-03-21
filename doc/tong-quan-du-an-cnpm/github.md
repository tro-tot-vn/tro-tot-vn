---
description: Quy trình cơ bản khi phát triển 1 chức năng
---

# Github

* _<mark style="color:red;">**Cấm code trên nhánh dev và main xong đẩy code.**</mark>_
*   Lần đầu tiên kéo code về thì phải dùng câu lệnh này:&#x20;

    ```
    git clone -b dev <remote_repo>
    ```

    * Lí do: Câu lệnh này giúp bạn kéo code ở branch dev thay vì main.
* Switch sang **dev** branch ( nếu đang ở branch khác) bằng cầu lệnh `git checkout dev` , và dùng `git pull` để kéo source mới nhất về.
* Từ dev branch dùng lệnh `git checkout -b <tên branch mới> dev`&#x20;
* `<tên branch mới>` phải theo format `feature/<tên chức năng>`
* Phát triển chức chức năng trên branch mà bạn vừa tạo.
* Sau khi hoàn thành dùng `git push --set-upstream origin <tên branch>` để đẩy lên.

<figure><img src="../.gitbook/assets/z6378732572891_3a0d0fbb8c2cc271fd48c04ffcc6e2ae.jpg" alt=""><figcaption></figcaption></figure>

* Sau khi đẩy lên thì cần phải tạo **Pull Request** để có thể merge vô dev.

<figure><img src="../.gitbook/assets/z6378732556144_e23a298274a8cf9f4494019fb8223e65.jpg" alt=""><figcaption></figcaption></figure>

* Trên màn hình **Pull Request**  cần chú ý.
  * Branch 1: là branch đích, bắt buộc phải là dev
  * Branch 2: là branch của bạn tạo ra muốn được merge vào dev
* Sau đó nhấn click Create pull request.
