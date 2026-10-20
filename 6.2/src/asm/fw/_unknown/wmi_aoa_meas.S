/* wmi_aoa_meas @ 0x8e9580, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memcpy_fw, tof_mgr__ftm_req_handle
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_aoa_meas
wmi_aoa_meas:
	.global L_8e9580
L_8e9580:
	push_s blink
L_8e9582:
	bl.d L_8c01dc
L_8e9586:
	mov_s r2,0xc
L_8e9588:
	sub_s sp,sp,0x1c
L_8e958a:
	mov_s r13,r0
L_8e958c:
	mov_s r14,sp
L_8e958e:
	mov_s r15,0x8023fc
L_8e9594:
	mov_s r0,r14
L_8e9596:
	bl.d L_8c0380
L_8e959a:
	add r1,r15,0xc
L_8e959e:
	add_s r0,sp,0xc
L_8e95a0:
	mov_s r16,r0
L_8e95a2:
	add r1,r15,0x18
L_8e95a6:
	bl.d L_8c0380
L_8e95aa:
	mov_s r2,0x10
L_8e95ac:
	mov_s r2,0x0
L_8e95ae:
	st_s r2,[sp,0x0]
L_8e95b0:
	stb_s r2,[sp,0x4]
L_8e95b2:
	ldb_s r0,[r13,0x7]
L_8e95b4:
	mov_s r1,0x1
L_8e95b6:
	stb r0,[sp, 0x5]
L_8e95ba:
	stw r1,[sp, 0x6]
L_8e95be:
	ldb_s r0,[r13,0x6]
L_8e95c0:
	stb r2,[sp, 0xd]
L_8e95c4:
	stb_s r0,[sp,0xc]
L_8e95c6:
	mov_s r0,0x4
L_8e95c8:
	mov_s r3,0x2
L_8e95ca:
	stb r0,[sp, 0xf]
L_8e95ce:
	stb r3,[sp, 0xe]
L_8e95d2:
	stb_s r2,[sp,0x10]
L_8e95d4:
	stb r3,[sp, 0x11]
L_8e95d8:
	stw r2,[sp, 0x12]
L_8e95dc:
	ld_s r0,[r13]
L_8e95de:
	st_s r0,[sp,0x14]
L_8e95e0:
	ldw_s r0,[r13,0x4]
L_8e95e2:
	stw r0,[sp, 0x18]
L_8e95e6:
	stw r1,[sp, 0x1a]
L_8e95ea:
	ld_s r0,[gp,-0x74]
L_8e95ec:
	mov_s r1,r14
L_8e95ee:
	bl.d L_8c38e8
L_8e95f2:
	mov_s r2,r16
L_8e95f4:
	b.d L_8c0244
L_8e95f8:
	add_s sp,sp,0x1c
L_8e95fa:
	nop_s
