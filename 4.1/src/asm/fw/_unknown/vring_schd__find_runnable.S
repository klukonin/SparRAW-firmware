/* vring_schd__find_runnable @ 0x8c2fe4, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Found #%d V-ring to run.
 * Зовут его: l2_mgr__scan_complete_handle, l2mgr__disconnect_done, ps_assoc_mgr__set_awake_tsf
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, llist__pop_front, vring_schd__bind_if_free, vring_schd__is_vring_ready
 */
	.section .text.vring_schd__find_runnable,"ax",@progbits
	.global vring_schd__find_runnable
vring_schd__find_runnable:
	.global L_8c2fe4
L_8c2fe4:
	push_s blink
L_8c2fe6:
	bl L_8c02b8
L_8c2fea:
	mov r17,0x804600
L_8c2ff2:
	ld r1,[r17, 0x18]
L_8c2ff6:
	mov_s r14,0x804580
L_8c2ffc:
	bic_s r1,r1,r0
L_8c2ffe:
	ld r0,[r17, 0x14]
L_8c3002:
	st r1,[r17, 0x18]
L_8c3006:
	brlo.d r0,0x1,L_8c3078
L_8c300a:
	mov_s r15,0x0
	.global L_8c300c
L_8c300c:
	mul64 r15,0x38
L_8c3010:
	add r0,r14,0x24
L_8c3014:
	add r16,r0,mlo
L_8c3018:
	ld r0,[r16, 0x14]
L_8c301c:
	brne_s r0,0,L_8c306e
L_8c301e:
	mov_s r3,0x2
L_8c3020:
	b_s L_8c3034
	.global L_8c3022
L_8c3022:
	asl_s r0,r3,0x2
L_8c3024:
	add1_s r0,r0,r0
L_8c3026:
	add r1,r14,0xc
L_8c302a:
	add r4,r1,r0
L_8c302e:
	ld r13,[r4, 0x4]
L_8c3032:
	brne_s r13,0,L_8c303e
	.global L_8c3034
L_8c3034:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8c3036:
	cmp r3,-0x1
L_8c303a:
	bne_s L_8c3022
L_8c303c:
	b_s L_8c306e
	.global L_8c303e
L_8c303e:
	mov_s r0,r14
L_8c3040:
	bl.d L_8c588c
L_8c3044:
	ldb_s r1,[r13,0xa]
L_8c3046:
	brne_s r0,0,L_8c3034
L_8c3048:
	ldb_s r0,[r13,0x8]
L_8c304a:
	brne r15,r0,L_8c3034
L_8c304e:
	bl.d L_8de2d4
L_8c3052:
	mov_s r0,r4
L_8c3054:
	mov_s r2,0x100a6f4
L_8c305a:
	mov_s r0,0x7
L_8c305c:
	mov_s r1,0x2
L_8c305e:
	bl.d L_8edfcc
L_8c3062:
	ldb_s r3,[r13,0x9]
L_8c3064:
	mov_s r0,r14
L_8c3066:
	mov_s r1,r13
L_8c3068:
	bl.d L_8c6300
L_8c306c:
	mov_s r2,r16
	.global L_8c306e
L_8c306e:
	ld r0,[r17, 0x14]
L_8c3072:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8c3074:
	brlo r15,r0,L_8c300c
	.global L_8c3078
L_8c3078:
	b L_8c031c
