/* wmi_evt__walk_list @ 0x8cafb4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_evt__fill_payload
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_evt__walk_list
wmi_evt__walk_list:
	.global L_8cafb4
L_8cafb4:
	push_s blink
L_8cafb6:
	bl L_8c01e0
L_8cafba:
	ld_s r14,[r1,0x4]
L_8cafbc:
	mov_s r13,r0
L_8cafbe:
	mov_s r15,r1
L_8cafc0:
	breq_s r14,0,L_8cb024
L_8cafc2:
	ld_s r0,[r15]
L_8cafc4:
	brne_s r0,0,L_8cb024
L_8cafc6:
	ldw_s r0,[r14,0x6]
L_8cafc8:
	bbit0 r0,0x1,L_8caff6
L_8cafcc:
	ld_s r0,[r13,0x18]
L_8cafce:
	breq_s r0,0,L_8cafe0
	.global L_8cafd0
L_8cafd0:
	ldw_s r0,[r14,0x6]
L_8cafd2:
	bbit1 r0,0x3,L_8cafea
L_8cafd6:
	ld_s r1,[r13,0x18]
L_8cafd8:
	add_s r14,r14,0x10
L_8cafda:
	jl_s.d [r1]
L_8cafdc:
	mov_s r0,r14
L_8cafde:
	b_s L_8cafee
	.global L_8cafe0
L_8cafe0:
	mov_s r0,blink
L_8cafe2:
	bl.d L_8c9b28
L_8cafe6:
	mov_s r1,0xc8
L_8cafe8:
	b_s L_8cafd0
	.global L_8cafea
L_8cafea:
	bclr_s r0,r0,0x3
L_8cafec:
	stw_s r0,[r14,0x6]
	.global L_8cafee
L_8cafee:
	ldw_s r0,[r14,0x6]
L_8caff0:
	bclr_s r0,r0,0x1
L_8caff2:
	stw_s r0,[r14,0x6]
L_8caff4:
	b_s L_8cb020
	.global L_8caff6
L_8caff6:
	bbit0 r0,0x2,L_8cb018
L_8caffa:
	ld_s r0,[r13,0x1c]
L_8caffc:
	add_s r14,r14,0x10
L_8caffe:
	breq_s r0,0,L_8cb00e
	.global L_8cb000
L_8cb000:
	ld_s r1,[r13,0x1c]
L_8cb002:
	jl_s.d [r1]
L_8cb004:
	mov_s r0,r14
L_8cb006:
	ldw_s r0,[r14,0x6]
L_8cb008:
	bclr_s r0,r0,0x2
L_8cb00a:
	stw_s r0,[r14,0x6]
L_8cb00c:
	b_s L_8cb020
	.global L_8cb00e
L_8cb00e:
	mov_s r0,blink
L_8cb010:
	bl.d L_8c9b28
L_8cb014:
	mov_s r1,0xc9
L_8cb016:
	b_s L_8cb000
	.global L_8cb018
L_8cb018:
	ld_s r0,[r13,0x10]
L_8cb01a:
	bl.d L_8caed0
L_8cb01e:
	mov_s r1,r14
	.global L_8cb020
L_8cb020:
	mov_s r0,0x0
L_8cb022:
	st_s r0,[r15,0x4]
	.global L_8cb024
L_8cb024:
	b L_8c024c
