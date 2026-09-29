/* hwd_phy__snapshot_status @ 0x8cf8e8, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, link_lost_diag__rx_status, phy_monitor__task_step
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, memset0_words
 */
	.section .text.hwd_phy__snapshot_status,"ax",@progbits
	.global hwd_phy__snapshot_status
hwd_phy__snapshot_status:
	.global L_8cf8e8
L_8cf8e8:
	push_s blink
L_8cf8ea:
	push_s r13
L_8cf8ec:
	mov.f r13,r0
L_8cf8f0:
	beq_s L_8cf942
	.global L_8cf8f2
L_8cf8f2:
	mov_s r0,r13
L_8cf8f4:
	bl.d L_8c1a78
L_8cf8f8:
	mov_s r1,0x38
L_8cf8fa:
	mov_s r0,0x883900
L_8cf900:
	ld_s r1,[r0,0x64]
L_8cf902:
	st_s r1,[r13]
L_8cf904:
	ld_s r1,[r0,0x68]
L_8cf906:
	st_s r1,[r13,0x4]
L_8cf908:
	ld_s r1,[r0,0x74]
L_8cf90a:
	st_s r1,[r13,0x8]
L_8cf90c:
	ld_s r1,[r0,0x6c]
L_8cf90e:
	st_s r1,[r13,0xc]
L_8cf910:
	ld_s r1,[r0,0x78]
L_8cf912:
	st_s r1,[r13,0x10]
L_8cf914:
	ld_s r1,[r0,0x70]
L_8cf916:
	st_s r1,[r13,0x14]
L_8cf918:
	ld_s r0,[r0,0x7c]
L_8cf91a:
	mov_s r1,0x883980
L_8cf920:
	st_s r0,[r13,0x18]
L_8cf922:
	ld_s r0,[r1,0x20]
L_8cf924:
	st_s r0,[r13,0x1c]
L_8cf926:
	ld_s r0,[r1,0x24]
L_8cf928:
	st_s r0,[r13,0x20]
L_8cf92a:
	ld_s r0,[r1,0x30]
L_8cf92c:
	st_s r0,[r13,0x24]
L_8cf92e:
	ld_s r0,[r1,0x28]
L_8cf930:
	st_s r0,[r13,0x28]
L_8cf932:
	ld_s r0,[r1,0x34]
L_8cf934:
	st_s r0,[r13,0x2c]
L_8cf936:
	ld_s r0,[r1,0x2c]
L_8cf938:
	st_s r0,[r13,0x30]
L_8cf93a:
	ld_s r0,[r1,0x38]
L_8cf93c:
	b.d L_8c033c
L_8cf940:
	st_s r0,[r13,0x34]
	.global L_8cf942
L_8cf942:
	mov_s r0,blink
L_8cf944:
	mov_s r2,0x1018690
L_8cf94a:
	mov_s r1,0xe2
L_8cf94c:
	bset_s r1,r1,0xc
L_8cf94e:
	bl.d L_8c82c0
L_8cf952:
	mov r3,0x3a6
L_8cf956:
	b_s L_8cf8f2
