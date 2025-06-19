![제목 없는 다이어그램 drawio (5)](https://github.com/user-attachments/assets/4b609c7a-039d-4e9f-8b08-7119738366bc)
<h1 align="center" style="color: #50C878;"> OrderLabs 🌿</h1>



<br><br>




## 🧑🏻‍🌾 프로젝트 개요

<div>
  
  **"자라는 만큼만 주문받는다."** <br>
</div>

이 서비스는 농·수산물의 생육 상태나 생물의 건강 데이터를 기반으로 주문 가능 여부를 
자동 판단하고 관리하는 스마트 주문 관리 플랫폼입니다. 
기존의 단순 재고 기반 판매 방식과 달리, 생물의 생육데이터 여기서는 공공 데이터(예: 
기상정보, 생육 센서 데이터 등)와 실시간 수집된 생물 정보(예: 수산물 성장률, 건강도)를 
분석하여 언제 주문을 받을 수 있고, 언제 배송이 가능한지를 예측 및 자동 통제합니다. 
이를 통해 생산자는 재고 과잉이나 무리한 주문을 방지하고, 소비자는 더 신선하고 정확한 
일정으로 상품을 수령할 수 있습니다. 
생물은 자라야 팔 수 있습니다. 우리는 그 ‘자라는 과정’까지 주문 시스템에 담습니다.

<br><br>

## 🕵️ 팀원 소개

<div align="center">

|   <img src="https://avatars.githubusercontent.com/u/149382180?v=4" width="100" height="100"/>   |   <img src="https://avatars.githubusercontent.com/u/96688099?v=4" width="100" height="100"/>   | <img src="https://avatars.githubusercontent.com/u/195714592?v=4" width="100" height="100"/>  |  <img src="https://avatars.githubusercontent.com/u/92301360?v=4" width="100" height="100"/>  |    <img src="https://avatars.githubusercontent.com/u/201225844?v=4" width="100" height="100"/>      |
| :--------------------------------------------------------: | :--------------------------------------------------------: | :--------------------------------------------------------: | :------------------------------------------------------: | :----------------------------------------------------------: |
| 🐰 **양승우**<br/>[@atimaby28](https://github.com/miyad927) | 🧶 **이시욱**<br/>[@David9733](https://github.com/David9733) | ⚽ **구창모**<br/>[@kucha240](https://github.com/kucha240) | 🐢 **유현경**<br/>[@gaangstar](https://github.com/gaangstar) | 🐉 **윤소민**<br/>[@somminn](https://github.com/somminn) |

</div>
<br>

## 📝 요구 사항 명세서
![요구사항2](./02_요구사항%20정의서.png)

<br><br>

## ☁️ ERD
![OrderLabs-erd](./03_ERD.png)
<div align=center>
  
  [⬆️ERD CLOUD 바로가기](https://www.erdcloud.com/d/GjgSeJRtpNC9jNFpG)
</div>

<br><br>

## ⚙️ 시스템 아키텍처
<img width="1324" alt="전체" src="./04_Architecture.png">

<br><br>

<div align=center>
    저희는 데이터 서버를 6대를 구성하였고 <br>
    두 서버는 Replication, 세 서버는 Clustering 나머지 한 서버는 연산을 위한 전용 서버로 구성하였습니다.
</div>

<br><br>

<details>
  <summary>Why replication?</summary>
  <br>
    운영 서버는 단일 DB 장애 시 전체 서비스가 중단되는 것을 막기 위해 Data Replication을 사용했습니다. 예를 들어, Master-Slave 구조로 구성해서 Master 장애 시 Slave로 자동 전환(Failover)이 가능하도록 했습니다. 이를 통해 서비스의 가용성과 안정성을 최우선으로 하였습니다.
  <br>
</details>

<details>
  <summary>Why database clustering?</summary>
  <br>
    작물 상태나 온도, 습도, 일사량 등의 실시간 기상 데이터가 끊기면 자동화 시스템이 오작동할 수 있어, 클러스터로 장애 대비를 했습니다.

</details>

<details>
  <summary>Why Calculate database?</summary>
  <br>
    운영 DB에 부하를 주지 않고 분석 작업과 계산 작업을 수행하기 위해 별도의 데이터베이스를 사용했습니다. 시계열 데이터를 다룬다는 점과 집계 쿼리를 반복 수행하기 위해, 운영 서비스 성능에 영향을 주지 않도록 했습니다.

</details>

<div class="markdown-heading" dir="auto"><h2 tabindex="-1" class="heading-element" dir="auto">📌 구축 쿼리 (DDL)</h2><a id="user-content--구축-쿼리-ddl" class="anchor" aria-label="Permalink: 📌 구축 쿼리 (DDL)" href="#-구축-쿼리-ddl"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path d="m7.775 3.275 1.25-1.25a3.5 3.5 0 1 1 4.95 4.95l-2.5 2.5a3.5 3.5 0 0 1-4.95 0 .751.751 0 0 1 .018-1.042.751.751 0 0 1 1.042-.018 1.998 1.998 0 0 0 2.83 0l2.5-2.5a2.002 2.002 0 0 0-2.83-2.83l-1.25 1.25a.751.751 0 0 1-1.042-.018.751.751 0 0 1-.018-1.042Zm-4.69 9.64a1.998 1.998 0 0 0 2.83 0l1.25-1.25a.751.751 0 0 1 1.042.018.751.751 0 0 1 .018 1.042l-1.25 1.25a3.5 3.5 0 1 1-4.95-4.95l2.5-2.5a3.5 3.5 0 0 1 4.95 0 .751.751 0 0 1-.018 1.042.751.751 0 0 1-1.042.018 1.998 1.998 0 0 0-2.83 0l-2.5 2.5a1.998 1.998 0 0 0 0 2.83Z"></path></svg></a></div>
<details>
<summary>🙆 회원 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="create table member (
    id			bigint primary key auto_increment,
    email			varchar(255) not null unique,
    name			varchar(255) not null,
    password		varchar(255) not null,
    account_date	datetime not null default CURRENT_TIMESTAMP,
    member_type		enum('user', 'company') default 'user',
    state			enum('online', 'offline', 'withdraw') default 'offline'
)"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">member</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    email			<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span> unique,
    name			<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    password		<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    account_date	datetime <span class="pl-k">not null</span> default <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    member_type		enum(<span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>company<span class="pl-pds">'</span></span>) default <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span>,
    state			enum(<span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>offline<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>withdraw<span class="pl-pds">'</span></span>) default <span class="pl-s"><span class="pl-pds">'</span>offline<span class="pl-pds">'</span></span>
)</pre></div>
</div>
</details>
<details>
<summary>🏢 회사 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="create table company (
    id			bigint primary key auto_increment,
    name			varchar(255) not null,
    address			varchar(255) not null,
    homepage		varchar(255) not null,
    phone_number	varchar(255) not null,
    member_id		bigint not null,
    foreign key(member_id) references member(id)
);"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">company</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    name			<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    address			<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    homepage		<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    phone_number	<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    member_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    <span class="pl-k">foreign key</span>(member_id) <span class="pl-k">references</span> member(id)
);</pre></div>
</div>
</details>
<details>
<summary>📋 이력서 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="create table resume (
    id			bigint primary key auto_increment,
    title			varchar(255) not null,
    contents		varchar(1000) not null,
    create_time		datetime not null default CURRENT_TIMESTAMP,
    update_time		datetime,
    member_id		bigint not null,
    foreign key(member_id) references member(id)
);"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">resume</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    title			<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    contents		<span class="pl-k">varchar</span>(<span class="pl-c1">1000</span>) <span class="pl-k">not null</span>,
    create_time		datetime <span class="pl-k">not null</span> default <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    update_time		datetime,
    member_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    <span class="pl-k">foreign key</span>(member_id) <span class="pl-k">references</span> member(id)
);</pre></div>
</div>
</details>
<details>
<summary>📣 채용 공고 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="create table job_posting (
    id			bigint primary key auto_increment,
    title			varchar(255) not null,
    contents		varchar(255) not null,
    career			varchar(1000) not null,
    salary			varchar(255) not null,
    category		varchar(255) not null,
    state			enum('hiring', 'deadline') default 'hiring',
    create_time		datetime not null default CURRENT_TIMESTAMP,
    deadline		datetime,
    company_id		bigint not null,
    foreign key(company_id) references company(id)
);"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">job_posting</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    title			<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    contents		<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    career			<span class="pl-k">varchar</span>(<span class="pl-c1">1000</span>) <span class="pl-k">not null</span>,
    salary			<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    category		<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>) <span class="pl-k">not null</span>,
    state			enum(<span class="pl-s"><span class="pl-pds">'</span>hiring<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>deadline<span class="pl-pds">'</span></span>) default <span class="pl-s"><span class="pl-pds">'</span>hiring<span class="pl-pds">'</span></span>,
    create_time		datetime <span class="pl-k">not null</span> default <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    deadline		datetime,
    company_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    <span class="pl-k">foreign key</span>(company_id) <span class="pl-k">references</span> company(id)
);</pre></div>
</div>
</details>
<details>
<summary>⏲ 지원 내역 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="create table appli_record (
    id			bigint primary key auto_increment,
    resume_id		bigint not null,
    posting_id		bigint not null,
    appli_time		datetime not null default CURRENT_TIMESTAMP,
    result          enum('apply', 'passed', 'failed') not null default 'apply',
    foreign key(resume_id) references resume(id),
    foreign key(posting_id) references job_posting(id)
);"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">appli_record</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    resume_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    posting_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    appli_time		datetime <span class="pl-k">not null</span> default <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    result          enum(<span class="pl-s"><span class="pl-pds">'</span>apply<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>passed<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>failed<span class="pl-pds">'</span></span>) <span class="pl-k">not null</span> default <span class="pl-s"><span class="pl-pds">'</span>apply<span class="pl-pds">'</span></span>,
    <span class="pl-k">foreign key</span>(resume_id) <span class="pl-k">references</span> resume(id),
    <span class="pl-k">foreign key</span>(posting_id) <span class="pl-k">references</span> job_posting(id)
);</pre></div>
</div>
</details>
<details>
<summary>📎 스크랩 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="create table scrap (
    id			bigint primary key auto_increment,
    member_id		bigint not null,
    posting_id		bigint not null,
    scrap_time		datetime not null default CURRENT_TIMESTAMP,
    foreign key(member_id) references member(id),
    foreign key(posting_id) references job_posting(id)
);"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">scrap</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    member_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    posting_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    scrap_time		datetime <span class="pl-k">not null</span> default <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    <span class="pl-k">foreign key</span>(member_id) <span class="pl-k">references</span> member(id),
    <span class="pl-k">foreign key</span>(posting_id) <span class="pl-k">references</span> job_posting(id)
);</pre></div>
</div>
</details>
<details>
<summary>⭐ 기업 리뷰 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="create table review (
    id			bigint primary key auto_increment,
    rating			decimal(2, 1) not null default 0.0,
    contents		varchar(1000) not null,
    create_time		datetime not null default CURRENT_TIMESTAMP,
    update_time		datetime,
    member_id		bigint not null,
    company_id		bigint not null,
    foreign key(member_id) references member(id),
    foreign key(company_id) references company(id)
);"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">review</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    rating			<span class="pl-k">decimal</span>(<span class="pl-c1">2</span>, <span class="pl-c1">1</span>) <span class="pl-k">not null</span> default <span class="pl-c1">0</span>.<span class="pl-c1">0</span>,
    contents		<span class="pl-k">varchar</span>(<span class="pl-c1">1000</span>) <span class="pl-k">not null</span>,
    create_time		datetime <span class="pl-k">not null</span> default <span class="pl-c1">CURRENT_TIMESTAMP</span>,
    update_time		datetime,
    member_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    company_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    <span class="pl-k">foreign key</span>(member_id) <span class="pl-k">references</span> member(id),
    <span class="pl-k">foreign key</span>(company_id) <span class="pl-k">references</span> company(id)
);</pre></div>
</div>
</details>
<details>
<summary>🔖 태그 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="create table tag (
    id			bigint primary key auto_increment,
    contents		varchar(255)
);"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">tag</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    contents		<span class="pl-k">varchar</span>(<span class="pl-c1">255</span>)
);</pre></div>
</div>
</details>
<details>
<summary>🔖 태그 리뷰 테이블</summary>
<div dir="auto">
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="create table tag_review (
    id			bigint primary key auto_increment,
    tag_id			bigint not null,
    review_id		bigint not null,
    foreign key(review_id) references review(id),
    foreign key(tag_id) references tag(id)
);"><pre><span class="pl-k">create</span> <span class="pl-k">table</span> <span class="pl-en">tag_review</span> (
    id			<span class="pl-k">bigint</span> <span class="pl-k">primary key</span> auto_increment,
    tag_id			<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    review_id		<span class="pl-k">bigint</span> <span class="pl-k">not null</span>,
    <span class="pl-k">foreign key</span>(review_id) <span class="pl-k">references</span> review(id),
    <span class="pl-k">foreign key</span>(tag_id) <span class="pl-k">references</span> tag(id)
);</pre></div>
</div>
</details>
<div class="markdown-heading" dir="auto"><h2 tabindex="-1" class="heading-element" dir="auto">📌 프로시저 구현</h2><a id="user-content--프로시저-구현" class="anchor" aria-label="Permalink: 📌 프로시저 구현" href="#-프로시저-구현"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path d="m7.775 3.275 1.25-1.25a3.5 3.5 0 1 1 4.95 4.95l-2.5 2.5a3.5 3.5 0 0 1-4.95 0 .751.751 0 0 1 .018-1.042.751.751 0 0 1 1.042-.018 1.998 1.998 0 0 0 2.83 0l2.5-2.5a2.002 2.002 0 0 0-2.83-2.83l-1.25 1.25a.751.751 0 0 1-1.042-.018.751.751 0 0 1-.018-1.042Zm-4.69 9.64a1.998 1.998 0 0 0 2.83 0l1.25-1.25a.751.751 0 0 1 1.042.018.751.751 0 0 1 .018 1.042l-1.25 1.25a3.5 3.5 0 1 1-4.95-4.95l2.5-2.5a3.5 3.5 0 0 1 4.95 0 .751.751 0 0 1-.018 1.042.751.751 0 0 1-1.042.018 1.998 1.998 0 0 0-2.83 0l-2.5 2.5a1.998 1.998 0 0 0 0 2.83Z"></path></svg></a></div>
<details>
<summary>🙆 회원 프로시저</summary>
<div dir="auto">    
<details>  
<summary> 회원 가입 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="delimiter //
CREATE PROCEDURE signup (in emailInput varchar(255), in nameInput varchar(255), in passwordInput varchar(255), in typeInput int)
begin
	if (select 1=1 from member where email = emailInput) then
		signal sqlstate '45000' set message_text = '이미 가입된 계정입니다.';
	else 
		if typeInput = 0 then
			insert into member(email, name, password) values(emailInput, nameInput, passwordInput);
            select '개인계정 가입 완료!' as message;
		else 
			insert into member(email, name, password, member_type) values(emailInput, nameInput, passwordInput, 'company');
            select '회사계정 가입 완료!' as message;
		end if;
	end if;
end //
delimiter ;"><pre>delimiter <span class="pl-k">//</span>
CREATE PROCEDURE signup (<span class="pl-k">in</span> emailInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> nameInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> passwordInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> typeInput <span class="pl-k">int</span>)
<span class="pl-k">begin</span>
	if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput) then
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>이미 가입된 계정입니다.<span class="pl-pds">'</span></span>;
	else 
		if typeInput <span class="pl-k">=</span> <span class="pl-c1">0</span> then
			<span class="pl-k">insert into</span> member(email, name, password) <span class="pl-k">values</span>(emailInput, nameInput, passwordInput);
            <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>개인계정 가입 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
		else 
			<span class="pl-k">insert into</span> member(email, name, password, member_type) <span class="pl-k">values</span>(emailInput, nameInput, passwordInput, <span class="pl-s"><span class="pl-pds">'</span>company<span class="pl-pds">'</span></span>);
            <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>회사계정 가입 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
		end if;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call signup('aa@naver.com', '호날두', '1234', 0);
call signup('ab@naver.com', '손흥민', '1234', 0);
call signup('ac@naver.com', '김민재', '1234', 0);
call signup('ad@naver.com', '메시', '1234', 1);
call signup('ae@naver.com', '홍명보', '1234', 1);"><pre>call signup(<span class="pl-s"><span class="pl-pds">'</span>aa@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>호날두<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1234<span class="pl-pds">'</span></span>, <span class="pl-c1">0</span>);
call signup(<span class="pl-s"><span class="pl-pds">'</span>ab@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>손흥민<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1234<span class="pl-pds">'</span></span>, <span class="pl-c1">0</span>);
call signup(<span class="pl-s"><span class="pl-pds">'</span>ac@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>김민재<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1234<span class="pl-pds">'</span></span>, <span class="pl-c1">0</span>);
call signup(<span class="pl-s"><span class="pl-pds">'</span>ad@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>메시<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1234<span class="pl-pds">'</span></span>, <span class="pl-c1">1</span>);
call signup(<span class="pl-s"><span class="pl-pds">'</span>ae@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>홍명보<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1234<span class="pl-pds">'</span></span>, <span class="pl-c1">1</span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452845524-dd52741d-81ce-48cf-9937-88d74274ec56.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ1NTI0LWRkNTI3NDFkLTgxY2UtNDhjZi05OTM3LTg4ZDc0Mjc0ZWM1Ni5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04NTZjNDQ5OTg4OWNmZTAwYTcyNjU3OTQxMmZhMTk5ZTJlMWIyMTk3MWQ3NjhjZTM5Yzk4ZGQzNDYxNzM3ZGFmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.1YxBPYvAlBvIk_RpY89SvHXv6Wls9e6_XACws907EDE"><img src="https://private-user-images.githubusercontent.com/146907065/452845524-dd52741d-81ce-48cf-9937-88d74274ec56.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ1NTI0LWRkNTI3NDFkLTgxY2UtNDhjZi05OTM3LTg4ZDc0Mjc0ZWM1Ni5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04NTZjNDQ5OTg4OWNmZTAwYTcyNjU3OTQxMmZhMTk5ZTJlMWIyMTk3MWQ3NjhjZTM5Yzk4ZGQzNDYxNzM3ZGFmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.1YxBPYvAlBvIk_RpY89SvHXv6Wls9e6_XACws907EDE" alt="회원_등록" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 로그인 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 로그인 프로시저
delimiter //
create procedure login (in emailInput varchar(255), in passwordInput varchar(255))
begin
	select password into @password from member where email = emailInput;
	if (select 1=1 from member where email = emailInput) then
		if @password = passwordInput then
			update member set state = 'online' where email = emailInput;
			select '로그인 완료!' as message;
		else
			signal sqlstate '45000' set message_text = '비밀번호가 틀렸습니다.';
		end if;
	else 
		signal sqlstate '45000' set message_text = '존재하지 않는 계정입니다.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 로그인 프로시저</span>
delimiter <span class="pl-k">//</span>
create procedure login (<span class="pl-k">in</span> emailInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> passwordInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>))
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> password into @password <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
	if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput) then
		if @password <span class="pl-k">=</span> passwordInput then
			<span class="pl-k">update</span> member <span class="pl-k">set</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
			<span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>로그인 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>비밀번호가 틀렸습니다.<span class="pl-pds">'</span></span>;
		end if;
	else 
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>존재하지 않는 계정입니다.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call login('aa@naver.com', '1234');"><pre>call login(<span class="pl-s"><span class="pl-pds">'</span>aa@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1234<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452846788-e210efa2-6bee-405c-8f10-2373390c7e89.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ2Nzg4LWUyMTBlZmEyLTZiZWUtNDA1Yy04ZjEwLTIzNzMzOTBjN2U4OS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03Mzc4YTYzZTAwOTdiMGEzNzc1ZTVlZWZlNmQxNGVhY2IxYjMzNGNhYjQ0YmY4ODJmNWRjNTI1MmQwYzhiMmM2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.Gw96NuF8ipGShnwWo0dVOMNadfeXXZ5XVIHAPtu4MNA"><img src="https://private-user-images.githubusercontent.com/146907065/452846788-e210efa2-6bee-405c-8f10-2373390c7e89.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ2Nzg4LWUyMTBlZmEyLTZiZWUtNDA1Yy04ZjEwLTIzNzMzOTBjN2U4OS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03Mzc4YTYzZTAwOTdiMGEzNzc1ZTVlZWZlNmQxNGVhY2IxYjMzNGNhYjQ0YmY4ODJmNWRjNTI1MmQwYzhiMmM2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.Gw96NuF8ipGShnwWo0dVOMNadfeXXZ5XVIHAPtu4MNA" alt="로그인" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 로그아웃 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 로그아웃 프로시저
delimiter //
create procedure logout (in emailInput varchar(255), in passwordInput varchar(255))
begin
	select password, state into @password, @state from member where email = emailInput;
	if (select 1=1 from member where email = emailInput) then
		if @password = passwordInput then
			if @state = 'online' then
				update member set state = 'offline' where email = emailInput;
				select '로그아웃 완료!' as message;
			else
				signal sqlstate '45000' set message_text = '온라인 상태가 아닙니다.';
			end if;
		else
			signal sqlstate '45000' set message_text = '비밀번호가 틀렸습니다.';
		end if;
	else 
		signal sqlstate '45000' set message_text = '존재하지 않는 계정입니다.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 로그아웃 프로시저</span>
delimiter <span class="pl-k">//</span>
create procedure logout (<span class="pl-k">in</span> emailInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> passwordInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>))
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> password, state into @password, @state <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
	if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput) then
		if @password <span class="pl-k">=</span> passwordInput then
			if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
				<span class="pl-k">update</span> member <span class="pl-k">set</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>offline<span class="pl-pds">'</span></span> <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
				<span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>로그아웃 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>온라인 상태가 아닙니다.<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>비밀번호가 틀렸습니다.<span class="pl-pds">'</span></span>;
		end if;
	else 
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>존재하지 않는 계정입니다.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call logout('aa@naver.com', '1234');"><pre>call logout(<span class="pl-s"><span class="pl-pds">'</span>aa@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1234<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452847210-8e6f551b-4831-48d1-9108-f980b539fc19.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ3MjEwLThlNmY1NTFiLTQ4MzEtNDhkMS05MTA4LWY5ODBiNTM5ZmMxOS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00NDRjMzhhNjU2ODgxMWI1ZDgyNTA1MGMyMDE0YjU3Mjg5OTVmMDk3ZWUwYmIxYWE4Y2U0NWQ4NTg5NDg4YjVkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.P2XMxJxV1NwVZYFUGMNIOJqbkavx1_wpStZlbzMgxSs"><img src="https://private-user-images.githubusercontent.com/146907065/452847210-8e6f551b-4831-48d1-9108-f980b539fc19.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ3MjEwLThlNmY1NTFiLTQ4MzEtNDhkMS05MTA4LWY5ODBiNTM5ZmMxOS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00NDRjMzhhNjU2ODgxMWI1ZDgyNTA1MGMyMDE0YjU3Mjg5OTVmMDk3ZWUwYmIxYWE4Y2U0NWQ4NTg5NDg4YjVkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.P2XMxJxV1NwVZYFUGMNIOJqbkavx1_wpStZlbzMgxSs" alt="로그아웃" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 유저 정보 수정 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 유저 정보 수정 프로시저
delimiter //
create procedure userupdate (in emailInput varchar(255), in nameInput varchar(255), in passwordInput varchar(255))
begin
	select state into @state from member where email = emailInput;
	if (select 1=1 from member where email = emailInput) then
		if @state = 'online' then
			update member set name = nameInput, password = passwordInput where email = emailInput;
			select '회원정보 수정 완료!' as message;
		else
			signal sqlstate '45000' set message_text = '오프라인 상태입니다.';
		end if;
	else 
		signal sqlstate '45000' set message_text = '존재하지 않는 계정입니다.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 유저 정보 수정 프로시저</span>
delimiter <span class="pl-k">//</span>
create procedure userupdate (<span class="pl-k">in</span> emailInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> nameInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> passwordInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>))
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state into @state <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
	if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput) then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			<span class="pl-k">update</span> member <span class="pl-k">set</span> name <span class="pl-k">=</span> nameInput, password <span class="pl-k">=</span> passwordInput <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
			<span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>회원정보 수정 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>오프라인 상태입니다.<span class="pl-pds">'</span></span>;
		end if;
	else 
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>존재하지 않는 계정입니다.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call userupdate('aa@naver.com', '호날두', '0123');"><pre>call userupdate(<span class="pl-s"><span class="pl-pds">'</span>aa@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>호날두<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>0123<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452847508-62df38c0-3609-40e3-8609-9d8bc21a222e.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ3NTA4LTYyZGYzOGMwLTM2MDktNDBlMy04NjA5LTlkOGJjMjFhMjIyZS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05YWY5YTg0ODI0NmU0YTBiNGUyMDExNTI4NTllZWU3YTBjMTg3N2Q5ZGU3MDUzYjQ5Y2U2Y2RiZGI2ZmEyY2M0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.e_AWJKgGHntb5Sgis0_ul5RKi9XWuSss9TRJBzYdia4"><img src="https://private-user-images.githubusercontent.com/146907065/452847508-62df38c0-3609-40e3-8609-9d8bc21a222e.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ3NTA4LTYyZGYzOGMwLTM2MDktNDBlMy04NjA5LTlkOGJjMjFhMjIyZS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05YWY5YTg0ODI0NmU0YTBiNGUyMDExNTI4NTllZWU3YTBjMTg3N2Q5ZGU3MDUzYjQ5Y2U2Y2RiZGI2ZmEyY2M0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.e_AWJKgGHntb5Sgis0_ul5RKi9XWuSss9TRJBzYdia4" alt="유저_정보_수정" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 회원 탈퇴 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 회원 탈퇴 프로시저
delimiter //
create procedure withdrawal (in emailInput varchar(255), in passwordInput varchar(255))
begin
	select state, password into @state, @password from member where email = emailInput;
	if (select 1=1 from member where email = emailInput) then
		if @state = 'online' then
			if @password = passwordInput then
				update member set state = 'withdraw' where email = emailInput;
				select '회원 탈퇴 완료!' as message;
			else
				signal sqlstate '45000' set message_text = '비밀번호가 틀렸습니다.';
			end if;
		else
			signal sqlstate '45000' set message_text = '오프라인 상태입니다.';
		end if;
	else 
		signal sqlstate '45000' set message_text = '존재하지 않는 계정입니다.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 회원 탈퇴 프로시저</span>
delimiter <span class="pl-k">//</span>
create procedure withdrawal (<span class="pl-k">in</span> emailInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> passwordInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>))
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, password into @state, @password <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
	if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput) then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			if @password <span class="pl-k">=</span> passwordInput then
				<span class="pl-k">update</span> member <span class="pl-k">set</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>withdraw<span class="pl-pds">'</span></span> <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
				<span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>회원 탈퇴 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>비밀번호가 틀렸습니다.<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>오프라인 상태입니다.<span class="pl-pds">'</span></span>;
		end if;
	else 
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>존재하지 않는 계정입니다.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call withdrawal('aa@naver.com', '0123');"><pre>call withdrawal(<span class="pl-s"><span class="pl-pds">'</span>aa@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>0123<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452848303-23d23bc0-8600-4e04-83c0-3bf6e7d045c5.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ4MzAzLTIzZDIzYmMwLTg2MDAtNGUwNC04M2MwLTNiZjZlN2QwNDVjNS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05YTNkMDQzMmM5NWRhMTg2MWFmOGY0YmE5MTg2NWRkYTY5N2UwMGYxZjA5NWJlNTE1YWQzOTQzNmEwMjIxYTZmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.JsuXAIJr3zQR1ZEgjzNXjRBhSbxWRxXVVLUK79ylNZI"><img src="https://private-user-images.githubusercontent.com/146907065/452848303-23d23bc0-8600-4e04-83c0-3bf6e7d045c5.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ4MzAzLTIzZDIzYmMwLTg2MDAtNGUwNC04M2MwLTNiZjZlN2QwNDVjNS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05YTNkMDQzMmM5NWRhMTg2MWFmOGY0YmE5MTg2NWRkYTY5N2UwMGYxZjA5NWJlNTE1YWQzOTQzNmEwMjIxYTZmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.JsuXAIJr3zQR1ZEgjzNXjRBhSbxWRxXVVLUK79ylNZI" alt="회원_탈퇴" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 회원 복구 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 회원 복구 프로시저
delimiter //
create procedure recovery (in emailInput varchar(255), in passwordInput varchar(255))
begin
	select state, password into @state, @password from member where email = emailInput;
	if (select 1=1 from member where email = emailInput) then
		if @state = 'withdraw' then
			if @password = passwordInput then
				update member set state = 'offline' where email = emailInput;
				select '회원복구 완료!' as message;
			else
				signal sqlstate '45000' set message_text = '비밀번호가 틀렸습니다.';
			end if;
		else
			signal sqlstate '45000' set message_text = '탈퇴한 계정이 아닙니다.';
		end if;
	else 
		signal sqlstate '45000' set message_text = '탈퇴한 계정이 아닙니다.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 회원 복구 프로시저</span>
delimiter <span class="pl-k">//</span>
create procedure recovery (<span class="pl-k">in</span> emailInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> passwordInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>))
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, password into @state, @password <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
	if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput) then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>withdraw<span class="pl-pds">'</span></span> then
			if @password <span class="pl-k">=</span> passwordInput then
				<span class="pl-k">update</span> member <span class="pl-k">set</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>offline<span class="pl-pds">'</span></span> <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
				<span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>회원복구 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>비밀번호가 틀렸습니다.<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>탈퇴한 계정이 아닙니다.<span class="pl-pds">'</span></span>;
		end if;
	else 
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>탈퇴한 계정이 아닙니다.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call recovery('aa@naver.com', '0123');"><pre>call recovery(<span class="pl-s"><span class="pl-pds">'</span>aa@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>0123<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452847963-5d2d4054-69e7-45f5-9c1c-485bc62eeec3.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ3OTYzLTVkMmQ0MDU0LTY5ZTctNDVmNS05YzFjLTQ4NWJjNjJlZWVjMy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1hMmQ2NzYwYWE5YzY2MWM5ZDM0NDNhN2E1NmE5YzAzYzdhMmZkOGFhZDhiNDc1ZDgxYTc1OGM0YTM3ZWFiZGZmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.t74or3o0Fyldv8mEYdcdMAiZjeJVyLKzaPdWWaNXjF4"><img src="https://private-user-images.githubusercontent.com/146907065/452847963-5d2d4054-69e7-45f5-9c1c-485bc62eeec3.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ3OTYzLTVkMmQ0MDU0LTY5ZTctNDVmNS05YzFjLTQ4NWJjNjJlZWVjMy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1hMmQ2NzYwYWE5YzY2MWM5ZDM0NDNhN2E1NmE5YzAzYzdhMmZkOGFhZDhiNDc1ZDgxYTc1OGM0YTM3ZWFiZGZmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.t74or3o0Fyldv8mEYdcdMAiZjeJVyLKzaPdWWaNXjF4" alt="회원_복구" style="max-width: 100%;"></a></p>
</details>
</div>
</details>
<details>
<summary>🏢 회사 프로시저</summary>
<div dir="auto">
<details>  
<summary> 회사 정보 등록 &amp; 수정 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 회사 정보 등록 and 수정 프로시저
delimiter //
create procedure companyinup (in emailInput varchar(255), in companynameInput varchar(255), in addressInput varchar(255), in homepageInput varchar(255), in phonenumInput varchar(255))
begin
	select state, member_type, id into @state, @type, @id from member where email = emailInput;
	if (select 1=1 from member where email = emailInput) then
		if @state = 'online' then
			if @type = 'company' then
				if (select 1=1 from company where member_id = @id) then
					update company set name = companynameInput, address = addressInput, homepage = homepageInput, phone_number = phonenumInput where member_id = @id;
					select '회사정보 수정 완료!' as message;
				else
					insert into company(name, address, homepage, phone_number, member_id) values(companynameInput, addressInput, homepageInput, phonenumInput, @id);
					select '회사정보 등록 완료!' as message;
				end if;
			else
				signal sqlstate '45000' set message_text = '회사 계정만 등록 가능';
			end if;
		else
			signal sqlstate '45000' set message_text = '온라인상태가 아닙니다.';
		end if;
	else 
		signal sqlstate '45000' set message_text = '존재하지 않는 계정입니다.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 회사 정보 등록 and 수정 프로시저</span>
delimiter <span class="pl-k">//</span>
create procedure companyinup (<span class="pl-k">in</span> emailInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> companynameInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> addressInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> homepageInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>), <span class="pl-k">in</span> phonenumInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>))
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, member_type, id into @state, @type, @id <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
	if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput) then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			if @type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>company<span class="pl-pds">'</span></span> then
				if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> company <span class="pl-k">where</span> member_id <span class="pl-k">=</span> @id) then
					<span class="pl-k">update</span> company <span class="pl-k">set</span> name <span class="pl-k">=</span> companynameInput, address <span class="pl-k">=</span> addressInput, homepage <span class="pl-k">=</span> homepageInput, phone_number <span class="pl-k">=</span> phonenumInput <span class="pl-k">where</span> member_id <span class="pl-k">=</span> @id;
					<span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>회사정보 수정 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
				else
					<span class="pl-k">insert into</span> company(name, address, homepage, phone_number, member_id) <span class="pl-k">values</span>(companynameInput, addressInput, homepageInput, phonenumInput, @id);
					<span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>회사정보 등록 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
				end if;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>회사 계정만 등록 가능<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>온라인상태가 아닙니다.<span class="pl-pds">'</span></span>;
		end if;
	else 
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>존재하지 않는 계정입니다.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 등록
call companyinup('ad@naver.com', '바르셀로나', '스페인 바르셀로나', 'www.ad.com', '010-1234-5678');

-- 수정 (프로시저 같음)
call companyinup('ad@naver.com', '바르셀로나', '스페인 바르셀로나', 'www.ad.com', '010-1234-1234');"><pre><span class="pl-c"><span class="pl-c">--</span> 등록</span>
call companyinup(<span class="pl-s"><span class="pl-pds">'</span>ad@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>바르셀로나<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>스페인 바르셀로나<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>www.ad.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>010-1234-5678<span class="pl-pds">'</span></span>);

<span class="pl-c"><span class="pl-c">--</span> 수정 (프로시저 같음)</span>
call companyinup(<span class="pl-s"><span class="pl-pds">'</span>ad@naver.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>바르셀로나<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>스페인 바르셀로나<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>www.ad.com<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>010-1234-1234<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452849775-05c5db8b-55b7-4976-b135-e9f4add1e74f.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ5Nzc1LTA1YzVkYjhiLTU1YjctNDk3Ni1iMTM1LWU5ZjRhZGQxZTc0Zi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iMDVmZGI3YWY4NjA2Zjk0NzFhNWZhOGI5YjliMDViYzFlNjI5Nzc0NjhiOTc5MDhlOGI4ZDM0Yjc4NjgwMDI4JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.SAsg4-PE_QEbGI9ol0XIlDyMvKA9TxzADHJNMc3QthQ"><img src="https://private-user-images.githubusercontent.com/146907065/452849775-05c5db8b-55b7-4976-b135-e9f4add1e74f.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ5Nzc1LTA1YzVkYjhiLTU1YjctNDk3Ni1iMTM1LWU5ZjRhZGQxZTc0Zi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iMDVmZGI3YWY4NjA2Zjk0NzFhNWZhOGI5YjliMDViYzFlNjI5Nzc0NjhiOTc5MDhlOGI4ZDM0Yjc4NjgwMDI4JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.SAsg4-PE_QEbGI9ol0XIlDyMvKA9TxzADHJNMc3QthQ" alt="회사_정보_등록" style="max-width: 100%;"></a></p>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452849878-10b0d88b-2d60-4f8c-979d-c6df71c48a9c.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ5ODc4LTEwYjBkODhiLTJkNjAtNGY4Yy05NzlkLWM2ZGY3MWM0OGE5Yy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT02OTM2NzA0OTk2MTI3YTlmMzQzODViZDdkMTU1YTJmMTk4ZmVmNGZjOWMzMTM0NGIwNzBiZWQwMGI5NzcwMzM5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.x5HQhhsJLNCrGpo5wK1H7FZd9Bd_gXTX8K5drqA4ni8"><img src="https://private-user-images.githubusercontent.com/146907065/452849878-10b0d88b-2d60-4f8c-979d-c6df71c48a9c.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODQ5ODc4LTEwYjBkODhiLTJkNjAtNGY4Yy05NzlkLWM2ZGY3MWM0OGE5Yy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT02OTM2NzA0OTk2MTI3YTlmMzQzODViZDdkMTU1YTJmMTk4ZmVmNGZjOWMzMTM0NGIwNzBiZWQwMGI5NzcwMzM5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.x5HQhhsJLNCrGpo5wK1H7FZd9Bd_gXTX8K5drqA4ni8" alt="회사_수정" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 회사 정보 삭제 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 회사 정보 삭제 프로시저
delimiter //
create procedure companydel (in emailInput varchar(255))
begin
	select state, member_type, id into @state, @type, @id from member where email = emailInput;
	if (select 1=1 from member where email = emailInput) then
		if @state = 'online' then
			if @type = 'company' then
				if (select 1=1 from company where member_id = @id) then
					delete from company where member_id = @id;
					select '회사 정보 삭제 완료!' as message;
				else
					signal sqlstate '45000' set message_text = '등록한 회사 정보가 없음';
				end if;
			else
				signal sqlstate '45000' set message_text = '회사 계정만 삭제 가능';
			end if;
		else
			signal sqlstate '45000' set message_text = '온라인 상태가 아닙니다.';
		end if;
	else 
		signal sqlstate '45000' set message_text = '존재하지 않는 계정입니다.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 회사 정보 삭제 프로시저</span>
delimiter <span class="pl-k">//</span>
create procedure companydel (<span class="pl-k">in</span> emailInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>))
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, member_type, id into @state, @type, @id <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput;
	if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> email <span class="pl-k">=</span> emailInput) then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			if @type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>company<span class="pl-pds">'</span></span> then
				if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> company <span class="pl-k">where</span> member_id <span class="pl-k">=</span> @id) then
					<span class="pl-k">delete</span> <span class="pl-k">from</span> company <span class="pl-k">where</span> member_id <span class="pl-k">=</span> @id;
					<span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>회사 정보 삭제 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
				else
					signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>등록한 회사 정보가 없음<span class="pl-pds">'</span></span>;
				end if;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>회사 계정만 삭제 가능<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>온라인 상태가 아닙니다.<span class="pl-pds">'</span></span>;
		end if;
	else 
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>존재하지 않는 계정입니다.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call companydel('ad@naver.com');"><pre>call companydel(<span class="pl-s"><span class="pl-pds">'</span>ad@naver.com<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452850127-741a9363-4f33-4732-b569-3eb2a29558a9.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODUwMTI3LTc0MWE5MzYzLTRmMzMtNDczMi1iNTY5LTNlYjJhMjk1NThhOS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1lMmIyMDY2NTE1OWQ0ZTYyZTFjNzZlZjNkMmIxY2JmMDcxMzk5NTliNThjM2E3M2NhMjQyNmViYjEzYmFlOTZiJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.r_jYn7Cso-WBxLCzA3dOeXKsYC9EXApboB_v5uiL0yo"><img src="https://private-user-images.githubusercontent.com/146907065/452850127-741a9363-4f33-4732-b569-3eb2a29558a9.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODUwMTI3LTc0MWE5MzYzLTRmMzMtNDczMi1iNTY5LTNlYjJhMjk1NThhOS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1lMmIyMDY2NTE1OWQ0ZTYyZTFjNzZlZjNkMmIxY2JmMDcxMzk5NTliNThjM2E3M2NhMjQyNmViYjEzYmFlOTZiJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.r_jYn7Cso-WBxLCzA3dOeXKsYC9EXApboB_v5uiL0yo" alt="회사_삭제" style="max-width: 100%;"></a></p>
</details>
</div>
</details>
<details>
<summary>📋 이력서 프로시저</summary>
<div dir="auto">
<details>  
<summary> 이력서 등록 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 이력서 등록 프로시저
-- 개인 계정 -&gt; 이력서 등록 (제목, 내용)
DELIMITER //
create procedure RESUME_001(
    in titleInput varchar(255),
    in contentsInput varchar(1000),
    in memberIdInput bigint
)
begin
    if exists(select 1 from member where id = memberIdInput and member_type = 'user' and state = 'online') then
        if (select 1 from resume where member_id = memberIdInput and title = titleInput) then
            -- 이미 등록된 이력서 제목이 존재하는 경우 오류 발생
            signal sqlstate '45000' set message_text = '이미 등록된 이력서 제목이 존재합니다.';
        else
            insert into resume (title, contents, member_id)
                values (titleInput, contentsInput, memberIdInput);

            -- 이력서 등록 성공 메세지
            select '이력서 등록 완료!' as message;
        end if;
    else
        -- 개인 계정이 아닌 경우 오류 발생
        signal sqlstate '45000' set message_text = '개인 계정만 등록 가능!';
    end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 이력서 등록 프로시저</span>
<span class="pl-c"><span class="pl-c">--</span> 개인 계정 -&gt; 이력서 등록 (제목, 내용)</span>
DELIMITER <span class="pl-k">//</span>
create procedure RESUME_001(
    <span class="pl-k">in</span> titleInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">in</span> contentsInput <span class="pl-k">varchar</span>(<span class="pl-c1">1000</span>),
    <span class="pl-k">in</span> memberIdInput <span class="pl-k">bigint</span>
)
<span class="pl-k">begin</span>
    if exists(<span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memberIdInput <span class="pl-k">and</span> member_type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span> <span class="pl-k">and</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span>) then
        if (<span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> resume <span class="pl-k">where</span> member_id <span class="pl-k">=</span> memberIdInput <span class="pl-k">and</span> title <span class="pl-k">=</span> titleInput) then
            <span class="pl-c"><span class="pl-c">--</span> 이미 등록된 이력서 제목이 존재하는 경우 오류 발생</span>
            signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>이미 등록된 이력서 제목이 존재합니다.<span class="pl-pds">'</span></span>;
        else
            <span class="pl-k">insert into</span> resume (title, contents, member_id)
                <span class="pl-k">values</span> (titleInput, contentsInput, memberIdInput);

            <span class="pl-c"><span class="pl-c">--</span> 이력서 등록 성공 메세지</span>
            <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>이력서 등록 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
        end if;
    else
        <span class="pl-c"><span class="pl-c">--</span> 개인 계정이 아닌 경우 오류 발생</span>
        signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>개인 계정만 등록 가능!<span class="pl-pds">'</span></span>;
    end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call RESUME_001('이력서1', '바르셀로나 지원합니다.', 1);
call RESUME_001('이력서2', '국가대표 공격수 지원합니다.', 2);
call RESUME_001('이력서3', '국가대표 수비수 지원합니다.', 3);"><pre>call RESUME_001(<span class="pl-s"><span class="pl-pds">'</span>이력서1<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>바르셀로나 지원합니다.<span class="pl-pds">'</span></span>, <span class="pl-c1">1</span>);
call RESUME_001(<span class="pl-s"><span class="pl-pds">'</span>이력서2<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>국가대표 공격수 지원합니다.<span class="pl-pds">'</span></span>, <span class="pl-c1">2</span>);
call RESUME_001(<span class="pl-s"><span class="pl-pds">'</span>이력서3<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>국가대표 수비수 지원합니다.<span class="pl-pds">'</span></span>, <span class="pl-c1">3</span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452854977-95aa9992-c1d0-4407-85b5-dc434d025f4b.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU0OTc3LTk1YWE5OTkyLWMxZDAtNDQwNy04NWI1LWRjNDM0ZDAyNWY0Yi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xYjhiYzUyM2RjZDBiOGMxYjNmZmYyMjFmMTIxMGZmM2Q3ZjM2ZjAyODUxZDVkZWQ0NGJjYzMxMWEzNWMyNzBjJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.KKGR3q9BO1Qm0NBcoo1DPqATv55gCaFd6HSMI8deR0A"><img src="https://private-user-images.githubusercontent.com/146907065/452854977-95aa9992-c1d0-4407-85b5-dc434d025f4b.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU0OTc3LTk1YWE5OTkyLWMxZDAtNDQwNy04NWI1LWRjNDM0ZDAyNWY0Yi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xYjhiYzUyM2RjZDBiOGMxYjNmZmYyMjFmMTIxMGZmM2Q3ZjM2ZjAyODUxZDVkZWQ0NGJjYzMxMWEzNWMyNzBjJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.KKGR3q9BO1Qm0NBcoo1DPqATv55gCaFd6HSMI8deR0A" alt="이력서_등록" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 이력서 수정 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 이력서 수정 프로시저
-- 이력서 내용 수정
delimiter //
create procedure RESUME_002(
    in memberIdInput bigint, 
    in idInput bigint,
    in titleInput varchar(255),
    in contentsInput varchar(1000))
begin
    -- 이력서 ID가 존재하는지 확인
    if exists(select 1 from member where id = memberIdInput and member_type = 'user' and state = 'online') then
        update resume
        set title = titleInput,
            contents = contentsInput,
            update_time = CURRENT_TIMESTAMP
        where id = idInput;

        select '이력서가 수정되었습니다.' as message;
    else
        -- 개인 계정이 아닌 경우 오류 발생
        signal sqlstate '45000' set message_text = '개인 계정 및 online 상태만 수정 가능!';
    end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 이력서 수정 프로시저</span>
<span class="pl-c"><span class="pl-c">--</span> 이력서 내용 수정</span>
delimiter <span class="pl-k">//</span>
create procedure RESUME_002(
    <span class="pl-k">in</span> memberIdInput <span class="pl-k">bigint</span>, 
    <span class="pl-k">in</span> idInput <span class="pl-k">bigint</span>,
    <span class="pl-k">in</span> titleInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">in</span> contentsInput <span class="pl-k">varchar</span>(<span class="pl-c1">1000</span>))
<span class="pl-k">begin</span>
    <span class="pl-c"><span class="pl-c">--</span> 이력서 ID가 존재하는지 확인</span>
    if exists(<span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memberIdInput <span class="pl-k">and</span> member_type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span> <span class="pl-k">and</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span>) then
        <span class="pl-k">update</span> resume
        <span class="pl-k">set</span> title <span class="pl-k">=</span> titleInput,
            contents <span class="pl-k">=</span> contentsInput,
            update_time <span class="pl-k">=</span> <span class="pl-c1">CURRENT_TIMESTAMP</span>
        <span class="pl-k">where</span> id <span class="pl-k">=</span> idInput;

        <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>이력서가 수정되었습니다.<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
    else
        <span class="pl-c"><span class="pl-c">--</span> 개인 계정이 아닌 경우 오류 발생</span>
        signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>개인 계정 및 online 상태만 수정 가능!<span class="pl-pds">'</span></span>;
    end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call RESUME_002(3, 3, '이력서4', '국가대표 수비수 지원합니다.');"><pre>call RESUME_002(<span class="pl-c1">3</span>, <span class="pl-c1">3</span>, <span class="pl-s"><span class="pl-pds">'</span>이력서4<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>국가대표 수비수 지원합니다.<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452855150-89e552f1-8f08-45b1-8072-30c122e4b75d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU1MTUwLTg5ZTU1MmYxLThmMDgtNDViMS04MDcyLTMwYzEyMmU0Yjc1ZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04NWU4YTIxYTgxMjBmODAxNWNlZmEyM2ViZDlmODcxY2UzZWYxMDgzYzlhYTJhN2NkZDhjZTk2YjJkNDRkODZhJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.A9gSE9n9LUYahvHfAPl7tBiK2jHgY3XLRottIBlwMzc"><img src="https://private-user-images.githubusercontent.com/146907065/452855150-89e552f1-8f08-45b1-8072-30c122e4b75d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU1MTUwLTg5ZTU1MmYxLThmMDgtNDViMS04MDcyLTMwYzEyMmU0Yjc1ZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04NWU4YTIxYTgxMjBmODAxNWNlZmEyM2ViZDlmODcxY2UzZWYxMDgzYzlhYTJhN2NkZDhjZTk2YjJkNDRkODZhJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.A9gSE9n9LUYahvHfAPl7tBiK2jHgY3XLRottIBlwMzc" alt="이력서_수정" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 이력서 삭제 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 이력서 삭제 프로시저
-- ✔️ 회사 계정 → 공고 삭제
delimiter //
create procedure RESUME_003(
    in memberIdInput bigint, 
    in idInput bigint
)
begin
    if exists(select 1 from member where id = memberIdInput and member_type = 'user' and state = 'online') then
        delete from resume
        where id = idInput;

        select '이력서가 삭제되었습니다.' as message;
    else
        -- 개인 계정이 아닌 경우 오류 발생
        signal sqlstate '45000' set message_text = '개인 계정 및 online 상태만 삭제 가능!';
    end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 이력서 삭제 프로시저</span>
<span class="pl-c"><span class="pl-c">--</span> ✔️ 회사 계정 → 공고 삭제</span>
delimiter <span class="pl-k">//</span>
create procedure RESUME_003(
    <span class="pl-k">in</span> memberIdInput <span class="pl-k">bigint</span>, 
    <span class="pl-k">in</span> idInput <span class="pl-k">bigint</span>
)
<span class="pl-k">begin</span>
    if exists(<span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memberIdInput <span class="pl-k">and</span> member_type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span> <span class="pl-k">and</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span>) then
        <span class="pl-k">delete</span> <span class="pl-k">from</span> resume
        <span class="pl-k">where</span> id <span class="pl-k">=</span> idInput;

        <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>이력서가 삭제되었습니다.<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
    else
        <span class="pl-c"><span class="pl-c">--</span> 개인 계정이 아닌 경우 오류 발생</span>
        signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>개인 계정 및 online 상태만 삭제 가능!<span class="pl-pds">'</span></span>;
    end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call RESUME_003(3, 3);"><pre>call RESUME_003(<span class="pl-c1">3</span>, <span class="pl-c1">3</span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452855284-bf7a025d-c5f5-471c-ba8f-b31541d7cd6d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU1Mjg0LWJmN2EwMjVkLWM1ZjUtNDcxYy1iYThmLWIzMTU0MWQ3Y2Q2ZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yZjQwYmI2NjZmMmIyYzZjMjQ4NjIwOWJmM2ZhNGJmY2I4OWEwYTVhYTc3OGE3ZDE5YzI4NWUxM2NhODYzMjY4JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.6uykkYLPZqln7RzOKLVHaaonLG7MAOF8QAsecrdXSuE"><img src="https://private-user-images.githubusercontent.com/146907065/452855284-bf7a025d-c5f5-471c-ba8f-b31541d7cd6d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU1Mjg0LWJmN2EwMjVkLWM1ZjUtNDcxYy1iYThmLWIzMTU0MWQ3Y2Q2ZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yZjQwYmI2NjZmMmIyYzZjMjQ4NjIwOWJmM2ZhNGJmY2I4OWEwYTVhYTc3OGE3ZDE5YzI4NWUxM2NhODYzMjY4JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.6uykkYLPZqln7RzOKLVHaaonLG7MAOF8QAsecrdXSuE" alt="이력서_삭제" style="max-width: 100%;"></a></p>
</details>
</div>
</details>
<details>
<summary>📣 채용 공고 프로시저</summary>
<div dir="auto">
<details>  
<summary> 공고 등록 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 공고 등록 프로시저
-- ✔️ 회사 계정 → 공고 등록 가능
-- 제목, 내용, 경력, 연봉, 마감시간, 카테고리, 상태
delimiter //
create procedure POSTING_001(
    IN memberIdInput BIGINT,
    IN titleInput VARCHAR(255),
    IN contentsInput VARCHAR(255),
    IN careerInput VARCHAR(1000),
    IN salaryInput VARCHAR(255),
    IN categoryInput VARCHAR(255),
    IN deadlineInput DATETIME
)
begin
    -- 회사 계정 ID 변수
    declare v_company_id bigint;

    -- 회사 계정 확인
    if exists(select 1 from member where id = memberIdInput and member_type = 'company' and state = 'online') then
        -- 회사 ID 조회
        select id into v_company_id from company where member_id = memberIdInput;

        -- 채용 공고 등록
        insert into job_posting(title, contents, career, salary, category, deadline, company_id)
            VALUES (titleInput, contentsInput, careerInput, salaryInput, categoryInput, deadlineInput, v_company_id);
    else
        -- 회사 계정이 아닌 경우 오류 발생
        signal sqlstate '45000' set message_text = '회사 계정만 등록 가능';
    end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 공고 등록 프로시저</span>
<span class="pl-c"><span class="pl-c">--</span> ✔️ 회사 계정 → 공고 등록 가능</span>
<span class="pl-c"><span class="pl-c">--</span> 제목, 내용, 경력, 연봉, 마감시간, 카테고리, 상태</span>
delimiter <span class="pl-k">//</span>
create procedure POSTING_001(
    <span class="pl-k">IN</span> memberIdInput <span class="pl-k">BIGINT</span>,
    <span class="pl-k">IN</span> titleInput <span class="pl-k">VARCHAR</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">IN</span> contentsInput <span class="pl-k">VARCHAR</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">IN</span> careerInput <span class="pl-k">VARCHAR</span>(<span class="pl-c1">1000</span>),
    <span class="pl-k">IN</span> salaryInput <span class="pl-k">VARCHAR</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">IN</span> categoryInput <span class="pl-k">VARCHAR</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">IN</span> deadlineInput DATETIME
)
<span class="pl-k">begin</span>
    <span class="pl-c"><span class="pl-c">--</span> 회사 계정 ID 변수</span>
    declare v_company_id <span class="pl-k">bigint</span>;

    <span class="pl-c"><span class="pl-c">--</span> 회사 계정 확인</span>
    if exists(<span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memberIdInput <span class="pl-k">and</span> member_type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>company<span class="pl-pds">'</span></span> <span class="pl-k">and</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span>) then
        <span class="pl-c"><span class="pl-c">--</span> 회사 ID 조회</span>
        <span class="pl-k">select</span> id into v_company_id <span class="pl-k">from</span> company <span class="pl-k">where</span> member_id <span class="pl-k">=</span> memberIdInput;

        <span class="pl-c"><span class="pl-c">--</span> 채용 공고 등록</span>
        <span class="pl-k">insert into</span> job_posting(title, contents, career, salary, category, deadline, company_id)
            <span class="pl-k">VALUES</span> (titleInput, contentsInput, careerInput, salaryInput, categoryInput, deadlineInput, v_company_id);
    else
        <span class="pl-c"><span class="pl-c">--</span> 회사 계정이 아닌 경우 오류 발생</span>
        signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>회사 계정만 등록 가능<span class="pl-pds">'</span></span>;
    end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call POSTING_001(4, '선수모집', '선수 구합니다', '1년', '3000만원', '스포츠', '2025-06-10');
call POSTING_001(5, '국가대표 모집', '선수 구합니다', '1년', '3000만원', '스포츠', '2025-06-09');"><pre>call POSTING_001(<span class="pl-c1">4</span>, <span class="pl-s"><span class="pl-pds">'</span>선수모집<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>선수 구합니다<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1년<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>3000만원<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>스포츠<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>2025-06-10<span class="pl-pds">'</span></span>);
call POSTING_001(<span class="pl-c1">5</span>, <span class="pl-s"><span class="pl-pds">'</span>국가대표 모집<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>선수 구합니다<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1년<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>3000만원<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>스포츠<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>2025-06-09<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452853903-d59500f8-6ca7-4d48-b1ef-6d6d56b1809a.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODUzOTAzLWQ1OTUwMGY4LTZjYTctNGQ0OC1iMWVmLTZkNmQ1NmIxODA5YS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT02ZjY4MjQzODcwMjNjNzg5MmQxYzc4MThmODRiMDJlNWQ4NWFiNjU3MTYzMTI1NWQwYTFhZTk5Mjk0Yjg5YjQ5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.KTOcp2pKO5Ft8R2_GTnVqlY01bNgUYL_amOU0MJULNk"><img src="https://private-user-images.githubusercontent.com/146907065/452853903-d59500f8-6ca7-4d48-b1ef-6d6d56b1809a.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODUzOTAzLWQ1OTUwMGY4LTZjYTctNGQ0OC1iMWVmLTZkNmQ1NmIxODA5YS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT02ZjY4MjQzODcwMjNjNzg5MmQxYzc4MThmODRiMDJlNWQ4NWFiNjU3MTYzMTI1NWQwYTFhZTk5Mjk0Yjg5YjQ5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.KTOcp2pKO5Ft8R2_GTnVqlY01bNgUYL_amOU0MJULNk" alt="공고_등록" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 공고 수정 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 공고 수정 프로시저
-- ✔️ 회사 계정 → 원하는 공고 수정 가능
-- 제목, 내용, 경력, 연봉, 마감시간, 카테고리
delimiter //
create procedure POSTING_002(
    in memberIdInput bigint,
    in postingIdInput bigint,
    in titleInput varchar(255),
    in contentsInput varchar(255),
    in careerInput varchar(1000),
    in salaryInput varchar(255),
    in categoryInput varchar(255),
    in deadlineInput datetime
)
begin
    -- 회사 계정 ID 변수
    declare v_company_id bigint;

    -- 회사 계정 확인
    if exists(select 1 from member where id = memberIdInput and member_type = 'company' and state = 'online') then
        select id into v_company_id from company where member_id = memberIdInput;

        -- 공고 ID &amp; 회사 ID 일치한지 확인
        if exists(select 1 from job_posting where id = postingIdInput and company_id = v_company_id) then
            update job_posting
            set title = titleInput,
                contents = contentsInput,
                career = careerInput,
                salary = salaryInput,
                category = categoryInput,
                deadline = deadlineInput
            where id = postingIdInput;
        else
            -- 공고가 존재하지 않거나 수정 권한이 없는 경우(회사ID 다른 경우) 오류 발생
            signal sqlstate '45000' set message_text = '수정 권한이 없거나 존재하지 않는 공고입니다.';
        end if;
    else
        -- 회사 계정이 아닌 경우 오류 발생
        signal sqlstate '45000' set message_text = '회사 계정만 수정 가능!';
    end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 공고 수정 프로시저</span>
<span class="pl-c"><span class="pl-c">--</span> ✔️ 회사 계정 → 원하는 공고 수정 가능</span>
<span class="pl-c"><span class="pl-c">--</span> 제목, 내용, 경력, 연봉, 마감시간, 카테고리</span>
delimiter <span class="pl-k">//</span>
create procedure POSTING_002(
    <span class="pl-k">in</span> memberIdInput <span class="pl-k">bigint</span>,
    <span class="pl-k">in</span> postingIdInput <span class="pl-k">bigint</span>,
    <span class="pl-k">in</span> titleInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">in</span> contentsInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">in</span> careerInput <span class="pl-k">varchar</span>(<span class="pl-c1">1000</span>),
    <span class="pl-k">in</span> salaryInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">in</span> categoryInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>),
    <span class="pl-k">in</span> deadlineInput datetime
)
<span class="pl-k">begin</span>
    <span class="pl-c"><span class="pl-c">--</span> 회사 계정 ID 변수</span>
    declare v_company_id <span class="pl-k">bigint</span>;

    <span class="pl-c"><span class="pl-c">--</span> 회사 계정 확인</span>
    if exists(<span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memberIdInput <span class="pl-k">and</span> member_type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>company<span class="pl-pds">'</span></span> <span class="pl-k">and</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span>) then
        <span class="pl-k">select</span> id into v_company_id <span class="pl-k">from</span> company <span class="pl-k">where</span> member_id <span class="pl-k">=</span> memberIdInput;

        <span class="pl-c"><span class="pl-c">--</span> 공고 ID &amp; 회사 ID 일치한지 확인</span>
        if exists(<span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> job_posting <span class="pl-k">where</span> id <span class="pl-k">=</span> postingIdInput <span class="pl-k">and</span> company_id <span class="pl-k">=</span> v_company_id) then
            <span class="pl-k">update</span> job_posting
            <span class="pl-k">set</span> title <span class="pl-k">=</span> titleInput,
                contents <span class="pl-k">=</span> contentsInput,
                career <span class="pl-k">=</span> careerInput,
                salary <span class="pl-k">=</span> salaryInput,
                category <span class="pl-k">=</span> categoryInput,
                deadline <span class="pl-k">=</span> deadlineInput
            <span class="pl-k">where</span> id <span class="pl-k">=</span> postingIdInput;
        else
            <span class="pl-c"><span class="pl-c">--</span> 공고가 존재하지 않거나 수정 권한이 없는 경우(회사ID 다른 경우) 오류 발생</span>
            signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>수정 권한이 없거나 존재하지 않는 공고입니다.<span class="pl-pds">'</span></span>;
        end if;
    else
        <span class="pl-c"><span class="pl-c">--</span> 회사 계정이 아닌 경우 오류 발생</span>
        signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>회사 계정만 수정 가능!<span class="pl-pds">'</span></span>;
    end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call POSTING_002(4, 1, '선수모집', '선수 구합니다', '1년', '3500만원', '스포츠', '2025-06-10');"><pre>call POSTING_002(<span class="pl-c1">4</span>, <span class="pl-c1">1</span>, <span class="pl-s"><span class="pl-pds">'</span>선수모집<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>선수 구합니다<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>1년<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>3500만원<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>스포츠<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>2025-06-10<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452854324-beab0ec5-fb90-4fb6-924c-5d854bd1bbcf.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU0MzI0LWJlYWIwZWM1LWZiOTAtNGZiNi05MjRjLTVkODU0YmQxYmJjZi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00NGFmOTExODBmYmMxZmIzZDNiZjc1N2Y3ZGFhNjBmZmVhZTFlOGZkOTkzMTJlOTZkN2Q3MWQxZjFhM2EwNTlhJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.LegwC1ipRXdipaf_CsvRR3EpV6WyiDmKNSWahuDW-8I"><img src="https://private-user-images.githubusercontent.com/146907065/452854324-beab0ec5-fb90-4fb6-924c-5d854bd1bbcf.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU0MzI0LWJlYWIwZWM1LWZiOTAtNGZiNi05MjRjLTVkODU0YmQxYmJjZi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00NGFmOTExODBmYmMxZmIzZDNiZjc1N2Y3ZGFhNjBmZmVhZTFlOGZkOTkzMTJlOTZkN2Q3MWQxZjFhM2EwNTlhJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.LegwC1ipRXdipaf_CsvRR3EpV6WyiDmKNSWahuDW-8I" alt="공고_수정" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 공고 상태 변경 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 공고 상태 변경 프로시저
-- ✔️ 회사 계정 → 공고 마감시간 지날 시에 상태 변경
# (기본은 고용중(hiring) &gt; 마감(deadline)으로 상태 변경)
delimiter //
create procedure POSTING_003()
begin
    update job_posting
    set state = 'deadline'
    where deadline &lt; now()
    and state = 'hiring';
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 공고 상태 변경 프로시저</span>
<span class="pl-c"><span class="pl-c">--</span> ✔️ 회사 계정 → 공고 마감시간 지날 시에 상태 변경</span>
<span class="pl-c"><span class="pl-c">#</span> (기본은 고용중(hiring) &gt; 마감(deadline)으로 상태 변경)</span>
delimiter <span class="pl-k">//</span>
create procedure POSTING_003()
<span class="pl-k">begin</span>
    <span class="pl-k">update</span> job_posting
    <span class="pl-k">set</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>deadline<span class="pl-pds">'</span></span>
    <span class="pl-k">where</span> deadline <span class="pl-k">&lt;</span> now()
    <span class="pl-k">and</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>hiring<span class="pl-pds">'</span></span>;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call POSTING_003();"><pre>call POSTING_003();</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452854495-609e72f5-c132-4329-9275-c32e523de93d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU0NDk1LTYwOWU3MmY1LWMxMzItNDMyOS05Mjc1LWMzMmU1MjNkZTkzZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04MDhiMTg2OGE4M2JjYjU2MDFmNTBhOGNjY2RjNDE5YjVhODNkMDYyNDY4MGYyYjMzYTM5NDkwMjBhOWM0YjY5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.RwqhG4rb1Tvr_X189dFB1d1Qd1Wib6OnCHsOgZgbwqk"><img src="https://private-user-images.githubusercontent.com/146907065/452854495-609e72f5-c132-4329-9275-c32e523de93d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU0NDk1LTYwOWU3MmY1LWMxMzItNDMyOS05Mjc1LWMzMmU1MjNkZTkzZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04MDhiMTg2OGE4M2JjYjU2MDFmNTBhOGNjY2RjNDE5YjVhODNkMDYyNDY4MGYyYjMzYTM5NDkwMjBhOWM0YjY5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.RwqhG4rb1Tvr_X189dFB1d1Qd1Wib6OnCHsOgZgbwqk" alt="공고_상태_등록" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 공고 삭제 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 공고 삭제 프로시저
-- ✔️ 회사 계정 → 공고 삭제
delimiter //
create procedure POSTING_004(
    in memberIdInput bigint,
    in postingIdInput bigint
)
begin
    -- 회사 계정 ID 변수
    declare v_company_id bigint;

    -- 회사 계정 확인
    if exists(select 1 from member where id = memberIdInput and member_type = 'company' and state = 'online') then
        select id into v_company_id from company where member_id = memberIdInput;

        -- 공고 ID &amp; 회사 ID 일치한지 확인
        if exists(select 1 from job_posting where id = postingIdInput and company_id = v_company_id) then
            delete from job_posting where id = postingIdInput;
        else
            -- 공고가 존재하지 않거나 삭제 권한이 없는 경우(회사ID 다른 경우) 오류 발생
            signal sqlstate '45000' set message_text = '삭제 권한 없거나 존재하지 않는 공고입니다!';
        end if;
    else
        -- 회사 계정이 아닌 경우 오류 발생
        signal sqlstate '45000' set message_text = '회사 계정만 삭제 가능!';
    end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 공고 삭제 프로시저</span>
<span class="pl-c"><span class="pl-c">--</span> ✔️ 회사 계정 → 공고 삭제</span>
delimiter <span class="pl-k">//</span>
create procedure POSTING_004(
    <span class="pl-k">in</span> memberIdInput <span class="pl-k">bigint</span>,
    <span class="pl-k">in</span> postingIdInput <span class="pl-k">bigint</span>
)
<span class="pl-k">begin</span>
    <span class="pl-c"><span class="pl-c">--</span> 회사 계정 ID 변수</span>
    declare v_company_id <span class="pl-k">bigint</span>;

    <span class="pl-c"><span class="pl-c">--</span> 회사 계정 확인</span>
    if exists(<span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memberIdInput <span class="pl-k">and</span> member_type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>company<span class="pl-pds">'</span></span> <span class="pl-k">and</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span>) then
        <span class="pl-k">select</span> id into v_company_id <span class="pl-k">from</span> company <span class="pl-k">where</span> member_id <span class="pl-k">=</span> memberIdInput;

        <span class="pl-c"><span class="pl-c">--</span> 공고 ID &amp; 회사 ID 일치한지 확인</span>
        if exists(<span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> job_posting <span class="pl-k">where</span> id <span class="pl-k">=</span> postingIdInput <span class="pl-k">and</span> company_id <span class="pl-k">=</span> v_company_id) then
            <span class="pl-k">delete</span> <span class="pl-k">from</span> job_posting <span class="pl-k">where</span> id <span class="pl-k">=</span> postingIdInput;
        else
            <span class="pl-c"><span class="pl-c">--</span> 공고가 존재하지 않거나 삭제 권한이 없는 경우(회사ID 다른 경우) 오류 발생</span>
            signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>삭제 권한 없거나 존재하지 않는 공고입니다!<span class="pl-pds">'</span></span>;
        end if;
    else
        <span class="pl-c"><span class="pl-c">--</span> 회사 계정이 아닌 경우 오류 발생</span>
        signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>회사 계정만 삭제 가능!<span class="pl-pds">'</span></span>;
    end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call POSTING_004(5, 2);"><pre>call POSTING_004(<span class="pl-c1">5</span>, <span class="pl-c1">2</span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452854591-83d57fd1-bd4f-4d2a-914f-a1d1496d0e04.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU0NTkxLTgzZDU3ZmQxLWJkNGYtNGQyYS05MTRmLWExZDE0OTZkMGUwNC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1kOWE2YjExYmZlMmZlMGJlOWM1ZDJjYTg1Zjc4MmRlOTE1YjliOTAxYTE3YzFlZDc2NjhkMzdlNGMxODJiNWJmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.m0_wZ_gjJiyR3Tfg5-7LLlRFXEcWjl8WOsbamC61lWU"><img src="https://private-user-images.githubusercontent.com/146907065/452854591-83d57fd1-bd4f-4d2a-914f-a1d1496d0e04.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU0NTkxLTgzZDU3ZmQxLWJkNGYtNGQyYS05MTRmLWExZDE0OTZkMGUwNC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1kOWE2YjExYmZlMmZlMGJlOWM1ZDJjYTg1Zjc4MmRlOTE1YjliOTAxYTE3YzFlZDc2NjhkMzdlNGMxODJiNWJmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.m0_wZ_gjJiyR3Tfg5-7LLlRFXEcWjl8WOsbamC61lWU" alt="공고_삭제" style="max-width: 100%;"></a></p>
</details>
</div>
</details>
<details>
<summary>⏲ 지원 내역 프로시저</summary>
<div dir="auto">
<details>
<summary> 이력서 지원 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 지원 내역 프로시저
-- 이력서 지원
-- ✔️ 사용자의 이력서를 공고에 지원
delimiter //
create procedure APPLY_001(
    in memberIdInput bigint,
    in resumeIdInput bigint,
    in postingIdInput bigint
)
begin
    declare v_resume_owner bigint;
    declare v_deadline datetime;

    -- 회원 상태 확인
    IF EXISTS (
        select 1 from member
        where id = memberIdInput and state = 'online'
    ) then
        -- 이력서 소유자 확인
        select member_id into v_resume_owner from resume where id = resumeIdInput;
        select deadline into v_deadline from job_posting where id = postingIdInput;

        if v_resume_owner = memberIdInput then
            if v_deadline is null or v_deadline &gt; now() then
                insert into appli_record (resume_id, posting_id)
                values (resumeIdInput, postingIdInput);
            else
                signal sqlstate '45000'
                    set message_text = '해당 공고는 마감되었습니다. 지원할 수 없습니다.';
            end if;
        else
            signal sqlstate '45000'
                set message_text = '해당 이력서는 이 회원의 것이 아닙니다.';
        end if;
    else
        signal sqlstate '45000'
            set message_text = '회원 상태가 online일 경우에만 지원할 수 있습니다.';
    end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 지원 내역 프로시저</span>
<span class="pl-c"><span class="pl-c">--</span> 이력서 지원</span>
<span class="pl-c"><span class="pl-c">--</span> ✔️ 사용자의 이력서를 공고에 지원</span>
delimiter <span class="pl-k">//</span>
create procedure APPLY_001(
    <span class="pl-k">in</span> memberIdInput <span class="pl-k">bigint</span>,
    <span class="pl-k">in</span> resumeIdInput <span class="pl-k">bigint</span>,
    <span class="pl-k">in</span> postingIdInput <span class="pl-k">bigint</span>
)
<span class="pl-k">begin</span>
    declare v_resume_owner <span class="pl-k">bigint</span>;
    declare v_deadline datetime;

    <span class="pl-c"><span class="pl-c">--</span> 회원 상태 확인</span>
    IF EXISTS (
        <span class="pl-k">select</span> <span class="pl-c1">1</span> <span class="pl-k">from</span> member
        <span class="pl-k">where</span> id <span class="pl-k">=</span> memberIdInput <span class="pl-k">and</span> state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span>
    ) then
        <span class="pl-c"><span class="pl-c">--</span> 이력서 소유자 확인</span>
        <span class="pl-k">select</span> member_id into v_resume_owner <span class="pl-k">from</span> resume <span class="pl-k">where</span> id <span class="pl-k">=</span> resumeIdInput;
        <span class="pl-k">select</span> deadline into v_deadline <span class="pl-k">from</span> job_posting <span class="pl-k">where</span> id <span class="pl-k">=</span> postingIdInput;

        if v_resume_owner <span class="pl-k">=</span> memberIdInput then
            if v_deadline is <span class="pl-k">null</span> <span class="pl-k">or</span> v_deadline <span class="pl-k">&gt;</span> now() then
                <span class="pl-k">insert into</span> appli_record (resume_id, posting_id)
                <span class="pl-k">values</span> (resumeIdInput, postingIdInput);
            else
                signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span>
                    <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>해당 공고는 마감되었습니다. 지원할 수 없습니다.<span class="pl-pds">'</span></span>;
            end if;
        else
            signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span>
                <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>해당 이력서는 이 회원의 것이 아닙니다.<span class="pl-pds">'</span></span>;
        end if;
    else
        signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span>
            <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>회원 상태가 online일 경우에만 지원할 수 있습니다.<span class="pl-pds">'</span></span>;
    end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call APPLY_001(1, 1, 1);
call APPLY_001(2, 2, 3);
call APPLY_001(3, 4, 3);"><pre>call APPLY_001(<span class="pl-c1">1</span>, <span class="pl-c1">1</span>, <span class="pl-c1">1</span>);
call APPLY_001(<span class="pl-c1">2</span>, <span class="pl-c1">2</span>, <span class="pl-c1">3</span>);
call APPLY_001(<span class="pl-c1">3</span>, <span class="pl-c1">4</span>, <span class="pl-c1">3</span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452856503-6f5d3434-8a03-4362-b67e-d63a4c29b8cc.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU2NTAzLTZmNWQzNDM0LThhMDMtNDM2Mi1iNjdlLWQ2M2E0YzI5YjhjYy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01NjM1MDkzMjQ3Njc0OGM3YWEzMWVjMzMyOWNjYTNlM2QzMmUzNTNlYTQ2NDRiYzNlOWE5NDZmZGZlNTUxNGYxJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.aR2FZ18GLb2V-mclmlDRl1CTuj8JuASXKzZwj0RDXi0"><img src="https://private-user-images.githubusercontent.com/146907065/452856503-6f5d3434-8a03-4362-b67e-d63a4c29b8cc.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU2NTAzLTZmNWQzNDM0LThhMDMtNDM2Mi1iNjdlLWQ2M2E0YzI5YjhjYy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01NjM1MDkzMjQ3Njc0OGM3YWEzMWVjMzMyOWNjYTNlM2QzMmUzNTNlYTQ2NDRiYzNlOWE5NDZmZGZlNTUxNGYxJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.aR2FZ18GLb2V-mclmlDRl1CTuj8JuASXKzZwj0RDXi0" alt="지원_내역_조회" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 지원 상태 변경 (합/불) </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 지원 상태 변경(합격, 불합격)
delimiter //
create procedure changeresult (in memIdInput bigint, in postingIdInput bigint, in resumeIdInput bigint)
begin
	select state, member_type into @state, @type from member where id = memIdInput;
	if @type = 'company' then
		if @state = 'online' then
			select state into @post_state from job_posting where id = postingIdInput;
			if @post_state = 'deadline' then
				update appli_record set result = 'passed' where posting_id = postingIdInput and resume_id = resumeIdInput;
				update appli_record set result = 'failed' where posting_id = postingIdInput and result = 'apply';
			else
				signal sqlstate '45000' set message_text = '채용중인 공고 입니다.';
			end if;
		else
			signal sqlstate '45000' set message_text = '온라인 상태가 아닙니다.';
		end if;
	else
		signal sqlstate '45000' set message_text = '회사 계정으로 로그인 하세요.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 지원 상태 변경(합격, 불합격)</span>
delimiter <span class="pl-k">//</span>
create procedure changeresult (<span class="pl-k">in</span> memIdInput <span class="pl-k">bigint</span>, <span class="pl-k">in</span> postingIdInput <span class="pl-k">bigint</span>, <span class="pl-k">in</span> resumeIdInput <span class="pl-k">bigint</span>)
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, member_type into @state, @type <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memIdInput;
	if @type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>company<span class="pl-pds">'</span></span> then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			<span class="pl-k">select</span> state into @post_state <span class="pl-k">from</span> job_posting <span class="pl-k">where</span> id <span class="pl-k">=</span> postingIdInput;
			if @post_state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>deadline<span class="pl-pds">'</span></span> then
				<span class="pl-k">update</span> appli_record <span class="pl-k">set</span> result <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>passed<span class="pl-pds">'</span></span> <span class="pl-k">where</span> posting_id <span class="pl-k">=</span> postingIdInput <span class="pl-k">and</span> resume_id <span class="pl-k">=</span> resumeIdInput;
				<span class="pl-k">update</span> appli_record <span class="pl-k">set</span> result <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>failed<span class="pl-pds">'</span></span> <span class="pl-k">where</span> posting_id <span class="pl-k">=</span> postingIdInput <span class="pl-k">and</span> result <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>apply<span class="pl-pds">'</span></span>;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>채용중인 공고 입니다.<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>온라인 상태가 아닙니다.<span class="pl-pds">'</span></span>;
		end if;
	else
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>회사 계정으로 로그인 하세요.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call changeresult(5, 3, 2);"><pre>call changeresult(<span class="pl-c1">5</span>, <span class="pl-c1">3</span>, <span class="pl-c1">2</span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452856406-f7967d1f-ebc4-4c97-b99e-319c9513adb6.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU2NDA2LWY3OTY3ZDFmLWViYzQtNGM5Ny1iOTllLTMxOWM5NTEzYWRiNi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03Y2I3NmU4YmEyYzQ2NWE1ZjFiMjBiMzljMGY5MWMyODJkNDI5NWNlYTQxNGEzNDMxM2Y2YjM3ZjQzNWI3NDcxJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.3KRmCJaHKCaVxxcJGLcEawsh6M_pyLd58Q2GA0naXSM"><img src="https://private-user-images.githubusercontent.com/146907065/452856406-f7967d1f-ebc4-4c97-b99e-319c9513adb6.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU2NDA2LWY3OTY3ZDFmLWViYzQtNGM5Ny1iOTllLTMxOWM5NTEzYWRiNi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03Y2I3NmU4YmEyYzQ2NWE1ZjFiMjBiMzljMGY5MWMyODJkNDI5NWNlYTQxNGEzNDMxM2Y2YjM3ZjQzNWI3NDcxJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.3KRmCJaHKCaVxxcJGLcEawsh6M_pyLd58Q2GA0naXSM" alt="지원결과상태변경" style="max-width: 100%;"></a></p>
</details>
</div>
</details>
<details>
<summary>📎 스크랩 프로시저</summary>
<div dir="auto">
<details>
<summary> 스크랩 추가 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 스크랩 추가
delimiter //
create procedure scrapinsert (in memIdInput bigint, in postingIdInput bigint)
begin
	select state, member_type into @state, @type from member where id = memIdInput;
	if @type = 'user' then
		if @state = 'online' then
			select state into @post_state from job_posting where id = postingIdInput;
			if @post_state = 'hiring' then
				insert into scrap(member_id, posting_id) values(memIdInput, postingIdInput);
                select '스크랩 추가 완료!' as message;
			else
				signal sqlstate '45000' set message_text = '채용중인 공고가 아닙니다.';
			end if;
		else
			signal sqlstate '45000' set message_text = '온라인 상태가 아닙니다.';
		end if;
	else
		signal sqlstate '45000' set message_text = '개인 계정으로 로그인 하세요.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 스크랩 추가</span>
delimiter <span class="pl-k">//</span>
create procedure scrapinsert (<span class="pl-k">in</span> memIdInput <span class="pl-k">bigint</span>, <span class="pl-k">in</span> postingIdInput <span class="pl-k">bigint</span>)
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, member_type into @state, @type <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memIdInput;
	if @type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span> then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			<span class="pl-k">select</span> state into @post_state <span class="pl-k">from</span> job_posting <span class="pl-k">where</span> id <span class="pl-k">=</span> postingIdInput;
			if @post_state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>hiring<span class="pl-pds">'</span></span> then
				<span class="pl-k">insert into</span> scrap(member_id, posting_id) <span class="pl-k">values</span>(memIdInput, postingIdInput);
                <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>스크랩 추가 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>채용중인 공고가 아닙니다.<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>온라인 상태가 아닙니다.<span class="pl-pds">'</span></span>;
		end if;
	else
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>개인 계정으로 로그인 하세요.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call scrapinsert(1, 1);"><pre>call scrapinsert(<span class="pl-c1">1</span>, <span class="pl-c1">1</span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452857005-3ba6b88e-37eb-4d29-8862-315c22fa0cb0.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU3MDA1LTNiYTZiODhlLTM3ZWItNGQyOS04ODYyLTMxNWMyMmZhMGNiMC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1lODdhNzBjOTkwMTA4NjZmZmZjYjRjZjAxODJjZjM3YTdjYzJjMGY4MjFlMTg5YTA5M2EzMjUwMGZiZjY2NjIyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.sKF1g8eZYZA9hu_HZdkdBC1OI48ExChFBqWcCE6_cgs"><img src="https://private-user-images.githubusercontent.com/146907065/452857005-3ba6b88e-37eb-4d29-8862-315c22fa0cb0.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU3MDA1LTNiYTZiODhlLTM3ZWItNGQyOS04ODYyLTMxNWMyMmZhMGNiMC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1lODdhNzBjOTkwMTA4NjZmZmZjYjRjZjAxODJjZjM3YTdjYzJjMGY4MjFlMTg5YTA5M2EzMjUwMGZiZjY2NjIyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.sKF1g8eZYZA9hu_HZdkdBC1OI48ExChFBqWcCE6_cgs" alt="스크랩_추가" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 스크랩 삭제 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 스크랩 삭제
delimiter //
create procedure scrapdelete (in memIdInput bigint, in scrapIdInput bigint)
begin
	select state, member_type into @state, @type from member where id = memIdInput;
	if @type = 'user' then
		if @state = 'online' then
			if (select 1=1 from scrap where id = scrapIdInput) then
				if (select 1=1 from scrap where id = scrapIdInput and member_id = memIdInput) then
					delete from scrap where id = scrapIdInput;
                    select '스크랩 삭제 완료!' as message;
				else
					signal sqlstate '45000' set message_text = '본인 스크랩이 아닙니다.';
				end if;
			else
				signal sqlstate '45000' set message_text = '스크랩이 존재하지 않습니다.';
			end if;
		else
			signal sqlstate '45000' set message_text = '온라인 상태가 아닙니다.';
		end if;
	else
		signal sqlstate '45000' set message_text = '개인 계정으로 로그인 하세요.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 스크랩 삭제</span>
delimiter <span class="pl-k">//</span>
create procedure scrapdelete (<span class="pl-k">in</span> memIdInput <span class="pl-k">bigint</span>, <span class="pl-k">in</span> scrapIdInput <span class="pl-k">bigint</span>)
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, member_type into @state, @type <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memIdInput;
	if @type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span> then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> scrap <span class="pl-k">where</span> id <span class="pl-k">=</span> scrapIdInput) then
				if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> scrap <span class="pl-k">where</span> id <span class="pl-k">=</span> scrapIdInput <span class="pl-k">and</span> member_id <span class="pl-k">=</span> memIdInput) then
					<span class="pl-k">delete</span> <span class="pl-k">from</span> scrap <span class="pl-k">where</span> id <span class="pl-k">=</span> scrapIdInput;
                    <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>스크랩 삭제 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
				else
					signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>본인 스크랩이 아닙니다.<span class="pl-pds">'</span></span>;
				end if;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>스크랩이 존재하지 않습니다.<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>온라인 상태가 아닙니다.<span class="pl-pds">'</span></span>;
		end if;
	else
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>개인 계정으로 로그인 하세요.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call scrapdelete(1, 1);"><pre>call scrapdelete(<span class="pl-c1">1</span>, <span class="pl-c1">1</span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452857345-90a37e59-35fc-4db2-b7cc-8d180b2d785a.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU3MzQ1LTkwYTM3ZTU5LTM1ZmMtNGRiMi1iN2NjLThkMTgwYjJkNzg1YS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01NDFmN2NhZjY3YTg4ZDQwYzg5MWQ4MzI2YTNmOWFlYjA1MjczNTM5NjZhZWEyNDg5ZDUzZjViOGQxN2Y4YWI2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.wCWVxatiFISkN_ytZtLd2OgsMadIbko6w63JNAAxalg"><img src="https://private-user-images.githubusercontent.com/146907065/452857345-90a37e59-35fc-4db2-b7cc-8d180b2d785a.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU3MzQ1LTkwYTM3ZTU5LTM1ZmMtNGRiMi1iN2NjLThkMTgwYjJkNzg1YS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01NDFmN2NhZjY3YTg4ZDQwYzg5MWQ4MzI2YTNmOWFlYjA1MjczNTM5NjZhZWEyNDg5ZDUzZjViOGQxN2Y4YWI2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.wCWVxatiFISkN_ytZtLd2OgsMadIbko6w63JNAAxalg" alt="스크랩_삭제" style="max-width: 100%;"></a></p>
</details>
</div>
</details>
<details>
<summary>⭐ 기업 리뷰 프로시저</summary>
<div dir="auto">
<details>
<summary> 리뷰 생성 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 리뷰 생성
delimiter //
create procedure reviewinsert (in memIdInput bigint, in companyIdInput bigint, in ratingInput decimal(2,1), in contentsInput varchar(1000), in tagInput varchar(255))
begin
	select state, member_type into @state, @type from member where id = memIdInput;
	if @type = 'user' then
		if @state = 'online' then
			if (select 1=1 from review where member_id = memIdInput and company_id = companyIdInput) then
				signal sqlstate '45000' set message_text = '이미 평가한 회사입니다.';
			else 
				insert into review(rating, contents, member_id, company_id) values(ratingInput, contentsInput, memIdInput, companyIdInput);
				select id into @review_id from review order by id desc limit 1;
				if (select 1=1 from tag where contents = tagInput) then
					select id into @tag_id from tag where contents = tagInput;
				else
					insert into tag(contents) values(tagInput);
					select id into @tag_id from tag order by id desc limit 1;
				end if;
				insert into tag_review(review_id, tag_id) values(@review_id, @tag_id);
                select '리뷰 등록 완료!' as message;
			end if;
		else
			signal sqlstate '45000' set message_text = '온라인 상태가 아닙니다.';
		end if;
	else
		signal sqlstate '45000' set message_text = '개인 계정으로 로그인 하세요.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 리뷰 생성</span>
delimiter <span class="pl-k">//</span>
create procedure reviewinsert (<span class="pl-k">in</span> memIdInput <span class="pl-k">bigint</span>, <span class="pl-k">in</span> companyIdInput <span class="pl-k">bigint</span>, <span class="pl-k">in</span> ratingInput <span class="pl-k">decimal</span>(<span class="pl-c1">2</span>,<span class="pl-c1">1</span>), <span class="pl-k">in</span> contentsInput <span class="pl-k">varchar</span>(<span class="pl-c1">1000</span>), <span class="pl-k">in</span> tagInput <span class="pl-k">varchar</span>(<span class="pl-c1">255</span>))
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, member_type into @state, @type <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memIdInput;
	if @type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span> then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> review <span class="pl-k">where</span> member_id <span class="pl-k">=</span> memIdInput <span class="pl-k">and</span> company_id <span class="pl-k">=</span> companyIdInput) then
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>이미 평가한 회사입니다.<span class="pl-pds">'</span></span>;
			else 
				<span class="pl-k">insert into</span> review(rating, contents, member_id, company_id) <span class="pl-k">values</span>(ratingInput, contentsInput, memIdInput, companyIdInput);
				<span class="pl-k">select</span> id into @review_id <span class="pl-k">from</span> review <span class="pl-k">order by</span> id <span class="pl-k">desc</span> <span class="pl-k">limit</span> <span class="pl-c1">1</span>;
				if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> tag <span class="pl-k">where</span> contents <span class="pl-k">=</span> tagInput) then
					<span class="pl-k">select</span> id into @tag_id <span class="pl-k">from</span> tag <span class="pl-k">where</span> contents <span class="pl-k">=</span> tagInput;
				else
					<span class="pl-k">insert into</span> tag(contents) <span class="pl-k">values</span>(tagInput);
					<span class="pl-k">select</span> id into @tag_id <span class="pl-k">from</span> tag <span class="pl-k">order by</span> id <span class="pl-k">desc</span> <span class="pl-k">limit</span> <span class="pl-c1">1</span>;
				end if;
				<span class="pl-k">insert into</span> tag_review(review_id, tag_id) <span class="pl-k">values</span>(@review_id, @tag_id);
                <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>리뷰 등록 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>온라인 상태가 아닙니다.<span class="pl-pds">'</span></span>;
		end if;
	else
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>개인 계정으로 로그인 하세요.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call reviewinsert(1, 2, 4.0, '좋아요', 'good');"><pre>call reviewinsert(<span class="pl-c1">1</span>, <span class="pl-c1">2</span>, <span class="pl-c1">4</span>.<span class="pl-c1">0</span>, <span class="pl-s"><span class="pl-pds">'</span>좋아요<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>good<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452858152-7c45eac7-14d4-4dae-87e4-f2147f6a6cf2.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU4MTUyLTdjNDVlYWM3LTE0ZDQtNGRhZS04N2U0LWYyMTQ3ZjZhNmNmMi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yZTZkNTMwZDVjODE2ZDYzYWFjNjEyNWJkZmI2N2Y0YzdjNzE1Y2U2ZTE5MmMwZDEwNmZlOWZhODU5YjFmODRiJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.OlaNwTeHPUW0FKZvXQ67-wBeni9nlIrx9sCuYDsc8yw"><img src="https://private-user-images.githubusercontent.com/146907065/452858152-7c45eac7-14d4-4dae-87e4-f2147f6a6cf2.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU4MTUyLTdjNDVlYWM3LTE0ZDQtNGRhZS04N2U0LWYyMTQ3ZjZhNmNmMi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yZTZkNTMwZDVjODE2ZDYzYWFjNjEyNWJkZmI2N2Y0YzdjNzE1Y2U2ZTE5MmMwZDEwNmZlOWZhODU5YjFmODRiJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.OlaNwTeHPUW0FKZvXQ67-wBeni9nlIrx9sCuYDsc8yw" alt="리뷰_생성" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 리뷰 수정 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 리뷰 수정
delimiter //
create procedure reviewupdate (in memIdInput bigint, in reviewIdInput bigint, in ratingInput decimal(2,1), in contentsInput varchar(1000))
begin
	select state, member_type into @state, @type from member where id = memIdInput;
	if @type = 'user' then
		if @state = 'online' then
			if(select 1=1 from review where id = reviewIdInput and member_id = memIdInput) then
				update review set rating = ratingInput, contents = contentsInput, update_time = now() where id = reviewIdInput;
                select '리뷰 수정 완료!' as message;
			else
				signal sqlstate '45000' set message_text = '본인 리뷰가 아닙니다.';
			end if;
		else
			signal sqlstate '45000' set message_text = '온라인 상태가 아닙니다.';
		end if;
	else
		signal sqlstate '45000' set message_text = '개인 계정으로 로그인 하세요.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 리뷰 수정</span>
delimiter <span class="pl-k">//</span>
create procedure reviewupdate (<span class="pl-k">in</span> memIdInput <span class="pl-k">bigint</span>, <span class="pl-k">in</span> reviewIdInput <span class="pl-k">bigint</span>, <span class="pl-k">in</span> ratingInput <span class="pl-k">decimal</span>(<span class="pl-c1">2</span>,<span class="pl-c1">1</span>), <span class="pl-k">in</span> contentsInput <span class="pl-k">varchar</span>(<span class="pl-c1">1000</span>))
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, member_type into @state, @type <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memIdInput;
	if @type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span> then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			if(<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> review <span class="pl-k">where</span> id <span class="pl-k">=</span> reviewIdInput <span class="pl-k">and</span> member_id <span class="pl-k">=</span> memIdInput) then
				<span class="pl-k">update</span> review <span class="pl-k">set</span> rating <span class="pl-k">=</span> ratingInput, contents <span class="pl-k">=</span> contentsInput, update_time <span class="pl-k">=</span> now() <span class="pl-k">where</span> id <span class="pl-k">=</span> reviewIdInput;
                <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>리뷰 수정 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>본인 리뷰가 아닙니다.<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>온라인 상태가 아닙니다.<span class="pl-pds">'</span></span>;
		end if;
	else
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>개인 계정으로 로그인 하세요.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call reviewupdate(1, 1, 3.5, '좋아요');"><pre>call reviewupdate(<span class="pl-c1">1</span>, <span class="pl-c1">1</span>, <span class="pl-c1">3</span>.<span class="pl-c1">5</span>, <span class="pl-s"><span class="pl-pds">'</span>좋아요<span class="pl-pds">'</span></span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452858043-1ad067df-0f61-4deb-abfc-6acc934b89cf.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU4MDQzLTFhZDA2N2RmLTBmNjEtNGRlYi1hYmZjLTZhY2M5MzRiODljZi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01NDA4MjBiOWY4ZmI5MTZlZTgzNTg0NGM2NzM0NWUwNGExNDdkMjNkNGI1NmRkNDY4ZGU0OWMyMjg3MjQ0NjEwJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.nIDSdIYqMlcYYxbXrfWcwDpiL2Mb472A_0XI_kQ76UM"><img src="https://private-user-images.githubusercontent.com/146907065/452858043-1ad067df-0f61-4deb-abfc-6acc934b89cf.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU4MDQzLTFhZDA2N2RmLTBmNjEtNGRlYi1hYmZjLTZhY2M5MzRiODljZi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01NDA4MjBiOWY4ZmI5MTZlZTgzNTg0NGM2NzM0NWUwNGExNDdkMjNkNGI1NmRkNDY4ZGU0OWMyMjg3MjQ0NjEwJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.nIDSdIYqMlcYYxbXrfWcwDpiL2Mb472A_0XI_kQ76UM" alt="리뷰_수정" style="max-width: 100%;"></a></p>
</details>
<details>
<summary> 리뷰 삭제 </summary>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="-- 리뷰 삭제
delimiter //
create procedure reviewdelete (in memIdInput bigint, in reviewIdInput bigint)
begin
	select state, member_type into @state, @type from member where id = memIdInput;
	if @type = 'user' then
		if @state = 'online' then
			if (select 1=1 from review where id = reviewIdInput and member_id = memIdInput) then
				delete from tag_review where review_id = reviewIdInput;
				delete from review where id = reviewIdInput;
                select '리뷰 삭제 완료!' as message;
			else
				signal sqlstate '45000' set message_text = '본인 리뷰가 아닙니다.';
			end if;
		else
			signal sqlstate '45000' set message_text = '온라인 상태가 아닙니다.';
		end if;
	else
		signal sqlstate '45000' set message_text = '개인 계정으로 로그인 하세요.';
	end if;
end //
delimiter ;"><pre><span class="pl-c"><span class="pl-c">--</span> 리뷰 삭제</span>
delimiter <span class="pl-k">//</span>
create procedure reviewdelete (<span class="pl-k">in</span> memIdInput <span class="pl-k">bigint</span>, <span class="pl-k">in</span> reviewIdInput <span class="pl-k">bigint</span>)
<span class="pl-k">begin</span>
	<span class="pl-k">select</span> state, member_type into @state, @type <span class="pl-k">from</span> member <span class="pl-k">where</span> id <span class="pl-k">=</span> memIdInput;
	if @type <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>user<span class="pl-pds">'</span></span> then
		if @state <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>online<span class="pl-pds">'</span></span> then
			if (<span class="pl-k">select</span> <span class="pl-c1">1</span><span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">from</span> review <span class="pl-k">where</span> id <span class="pl-k">=</span> reviewIdInput <span class="pl-k">and</span> member_id <span class="pl-k">=</span> memIdInput) then
				<span class="pl-k">delete</span> <span class="pl-k">from</span> tag_review <span class="pl-k">where</span> review_id <span class="pl-k">=</span> reviewIdInput;
				<span class="pl-k">delete</span> <span class="pl-k">from</span> review <span class="pl-k">where</span> id <span class="pl-k">=</span> reviewIdInput;
                <span class="pl-k">select</span> <span class="pl-s"><span class="pl-pds">'</span>리뷰 삭제 완료!<span class="pl-pds">'</span></span> <span class="pl-k">as</span> message;
			else
				signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>본인 리뷰가 아닙니다.<span class="pl-pds">'</span></span>;
			end if;
		else
			signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>온라인 상태가 아닙니다.<span class="pl-pds">'</span></span>;
		end if;
	else
		signal sqlstate <span class="pl-s"><span class="pl-pds">'</span>45000<span class="pl-pds">'</span></span> <span class="pl-k">set</span> message_text <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>개인 계정으로 로그인 하세요.<span class="pl-pds">'</span></span>;
	end if;
end <span class="pl-k">//</span>
delimiter ;</pre></div>
<div class="highlight highlight-source-sql notranslate position-relative overflow-auto" dir="auto" data-snippet-clipboard-copy-content="call reviewdelete(1, 1);"><pre>call reviewdelete(<span class="pl-c1">1</span>, <span class="pl-c1">1</span>);</pre></div>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://private-user-images.githubusercontent.com/146907065/452857990-d8c8ac2f-878e-4843-b5a8-34de04800601.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU3OTkwLWQ4YzhhYzJmLTg3OGUtNDg0My1iNWE4LTM0ZGUwNDgwMDYwMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0zMjA3Zjg0ODhmMjg0MDg3NmNkOTI2NzQzNmJiMjlhOGM2MDE4ZDEwYmVkYjdkYWZiODY4YzFjZGVjZjdkMTJmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.0xfDQjMPB5uNioDqj_B6McUseokk9r-jw-nYYC3s0fo"><img src="https://private-user-images.githubusercontent.com/146907065/452857990-d8c8ac2f-878e-4843-b5a8-34de04800601.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NTAzMzEyMzMsIm5iZiI6MTc1MDMzMDkzMywicGF0aCI6Ii8xNDY5MDcwNjUvNDUyODU3OTkwLWQ4YzhhYzJmLTg3OGUtNDg0My1iNWE4LTM0ZGUwNDgwMDYwMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxOVQxMTAyMTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0zMjA3Zjg0ODhmMjg0MDg3NmNkOTI2NzQzNmJiMjlhOGM2MDE4ZDEwYmVkYjdkYWZiODY4YzFjZGVjZjdkMTJmJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.0xfDQjMPB5uNioDqj_B6McUseokk9r-jw-nYYC3s0fo" alt="리뷰_삭제" style="max-width: 100%;"></a></p>
</details>
</div>

  </body>
</html>
