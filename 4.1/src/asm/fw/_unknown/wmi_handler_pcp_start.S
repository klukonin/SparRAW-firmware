/* wmi_handler_pcp_start @ 0x8e79dc, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: wmi_handler_bcon_ctrl
 */
	.section .text.wmi_handler_pcp_start,"ax",@progbits
	.global wmi_handler_pcp_start
wmi_handler_pcp_start:
	.global L_8e79dc
L_8e79dc:
	push_s blink
L_8e79de:
	ldw_s r2,[r0]
L_8e79e0:
	stw.a r2,[sp,-0x14]
L_8e79e4:
	mov_s r2,0x0
L_8e79e6:
	stw r2,[sp, 0x2]
L_8e79ea:
	st_s r2,[sp,0x4]
L_8e79ec:
	st_s r2,[sp,0x8]
L_8e79ee:
	ldb_s r2,[r0,0xc]
L_8e79f0:
	stb_s r2,[sp,0xc]
L_8e79f2:
	ldb_s r2,[r0,0x2]
L_8e79f4:
	stb r2,[sp, 0xd]
L_8e79f8:
	ldb_s r2,[r0,0x3]
L_8e79fa:
	stb_s r2,[sp,0x10]
L_8e79fc:
	ldb_s r2,[r0,0xe]
L_8e79fe:
	stb r2,[sp, 0xe]
L_8e7a02:
	ldb_s r2,[r0,0xf]
L_8e7a04:
	stb r2,[sp, 0xf]
L_8e7a08:
	ldb_s r2,[r0,0x4]
L_8e7a0a:
	stb r2,[sp, 0x11]
L_8e7a0e:
	ldb_s r2,[r0,0xd]
L_8e7a10:
	mov_s r0,0x8033dc
L_8e7a16:
	st_s r2,[r0]
L_8e7a18:
	bl.d L_8e7924
L_8e7a1c:
	mov_s r0,sp
L_8e7a1e:
	add_s sp,sp,0x14
L_8e7a20:
	pop_s blink
L_8e7a22:
	j_s [blink]
