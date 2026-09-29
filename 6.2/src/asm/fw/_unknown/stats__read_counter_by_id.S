/* stats__read_counter_by_id @ 0x8dd7b8, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_ampdu_statistics_timeout_cb, stats__delta_since_baseline
 * Зовёт сам: fw_sysassert_fatal
 * Глобалы (через gp): 0x8003d0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stats__read_counter_by_id
stats__read_counter_by_id:
	.global L_8dd7b8
L_8dd7b8:
	cmp_s r0,0x14
L_8dd7ba:
	bhi.d L_8dd894
L_8dd7be:
	push_s blink
L_8dd7c0:
	ldb.x r0,[0x801b6c,r0]
L_8dd7c8:
	add r2,pcl,0x8
L_8dd7cc:
	add1_s r2,r2,r0
L_8dd7ce:
	j_s [r2]
L_8dd7d0:
	ld_s r0,[gp,0x24c]
L_8dd7d2:
	ld_s r2,[r0,0x10]
L_8dd7d4:
	st_s r2,[r1]
L_8dd7d6:
	ld_s r0,[gp,0x24c]
L_8dd7d8:
	ld_s r0,[r0,0x48]
L_8dd7da:
	add_s r2,r2,r0
L_8dd7dc:
	b_s L_8dd8a2
L_8dd7de:
	ld_s r0,[gp,0x24c]
L_8dd7e0:
	ld_s r2,[r0,0x14]
L_8dd7e2:
	st_s r2,[r1]
L_8dd7e4:
	ld_s r0,[gp,0x24c]
L_8dd7e6:
	ld_s r0,[r0,0x4c]
L_8dd7e8:
	add_s r2,r2,r0
L_8dd7ea:
	b_s L_8dd8a2
L_8dd7ec:
	ld_s r0,[gp,0x24c]
L_8dd7ee:
	ld_s r2,[r0,0x18]
L_8dd7f0:
	st_s r2,[r1]
L_8dd7f2:
	ld_s r0,[gp,0x24c]
L_8dd7f4:
	ld_s r0,[r0,0x50]
L_8dd7f6:
	add_s r2,r2,r0
L_8dd7f8:
	b_s L_8dd8a2
L_8dd7fa:
	ld_s r0,[gp,0x24c]
L_8dd7fc:
	ld_s r2,[r0,0x1c]
L_8dd7fe:
	st_s r2,[r1]
L_8dd800:
	ld_s r0,[gp,0x24c]
L_8dd802:
	ld_s r0,[r0,0x54]
L_8dd804:
	add_s r2,r2,r0
L_8dd806:
	b_s L_8dd8a2
L_8dd808:
	ld_s r0,[gp,0x24c]
L_8dd80a:
	ld_s r2,[r0,0x20]
L_8dd80c:
	st_s r2,[r1]
L_8dd80e:
	ld_s r0,[gp,0x24c]
L_8dd810:
	ld_s r0,[r0,0x58]
L_8dd812:
	add_s r2,r2,r0
L_8dd814:
	b_s L_8dd8a2
L_8dd816:
	ld_s r0,[gp,0x24c]
L_8dd818:
	ld_s r2,[r0,0x24]
L_8dd81a:
	st_s r2,[r1]
L_8dd81c:
	ld_s r0,[gp,0x24c]
L_8dd81e:
	ld_s r0,[r0,0x5c]
L_8dd820:
	add_s r2,r2,r0
L_8dd822:
	b_s L_8dd8a2
L_8dd824:
	ld_s r0,[gp,0x24c]
L_8dd826:
	ld_s r2,[r0,0x28]
L_8dd828:
	st_s r2,[r1]
L_8dd82a:
	ld_s r0,[gp,0x24c]
L_8dd82c:
	ld_s r0,[r0,0x60]
L_8dd82e:
	add_s r2,r2,r0
L_8dd830:
	b_s L_8dd8a2
L_8dd832:
	ld_s r0,[gp,0x24c]
L_8dd834:
	ld_s r2,[r0,0x2c]
L_8dd836:
	st_s r2,[r1]
L_8dd838:
	ld_s r0,[gp,0x24c]
L_8dd83a:
	ld_s r0,[r0,0x64]
L_8dd83c:
	add_s r2,r2,r0
L_8dd83e:
	b_s L_8dd8a2
L_8dd840:
	ld_s r0,[gp,0x24c]
L_8dd842:
	ld_s r2,[r0,0x30]
L_8dd844:
	st_s r2,[r1]
L_8dd846:
	ld_s r0,[gp,0x24c]
L_8dd848:
	ld_s r0,[r0,0x68]
L_8dd84a:
	add_s r2,r2,r0
L_8dd84c:
	b_s L_8dd8a2
L_8dd84e:
	ld_s r0,[gp,0x24c]
L_8dd850:
	ld_s r2,[r0,0x34]
L_8dd852:
	st_s r2,[r1]
L_8dd854:
	ld_s r0,[gp,0x24c]
L_8dd856:
	ld_s r0,[r0,0x6c]
L_8dd858:
	add_s r2,r2,r0
L_8dd85a:
	b_s L_8dd8a2
L_8dd85c:
	ld_s r0,[gp,0x24c]
L_8dd85e:
	ld_s r2,[r0,0x38]
L_8dd860:
	st_s r2,[r1]
L_8dd862:
	ld_s r0,[gp,0x24c]
L_8dd864:
	ld_s r0,[r0,0x70]
L_8dd866:
	add_s r2,r2,r0
L_8dd868:
	b_s L_8dd8a2
L_8dd86a:
	ld_s r0,[gp,0x24c]
L_8dd86c:
	ld_s r2,[r0,0x3c]
L_8dd86e:
	st_s r2,[r1]
L_8dd870:
	ld_s r0,[gp,0x24c]
L_8dd872:
	ld_s r0,[r0,0x74]
L_8dd874:
	add_s r2,r2,r0
L_8dd876:
	b_s L_8dd8a2
L_8dd878:
	ld_s r0,[gp,0x24c]
L_8dd87a:
	ld_s r2,[r0,0x40]
L_8dd87c:
	st_s r2,[r1]
L_8dd87e:
	ld_s r0,[gp,0x24c]
L_8dd880:
	ld_s r0,[r0,0x78]
L_8dd882:
	add_s r2,r2,r0
L_8dd884:
	b_s L_8dd8a2
L_8dd886:
	ld_s r0,[gp,0x24c]
L_8dd888:
	ld_s r2,[r0,0x44]
L_8dd88a:
	st_s r2,[r1]
L_8dd88c:
	ld_s r0,[gp,0x24c]
L_8dd88e:
	ld_s r0,[r0,0x7c]
L_8dd890:
	add_s r2,r2,r0
L_8dd892:
	b_s L_8dd8a2
	.global L_8dd894
L_8dd894:
	mov_s r0,blink
L_8dd896:
	mov_s r1,0x125d
L_8dd89c:
	bl L_8c9b28
L_8dd8a0:
	mov_s r2,0x0
	.global L_8dd8a2
L_8dd8a2:
	mov_s r0,r2
L_8dd8a4:
	pop_s blink
L_8dd8a6:
	j_s [blink]
