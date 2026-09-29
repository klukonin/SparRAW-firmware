/* vring_ba__build_cfg @ 0x8e2058, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ut_hw_cmd_0x008
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s24_w2, bf_w_s29_w2, mac_indirect__write_entry, vring_ba__fill_fields
 */
	.section .text.vring_ba__build_cfg,"ax",@progbits
	.global vring_ba__build_cfg
vring_ba__build_cfg:
	.global L_8e2058
L_8e2058:
	push_s blink
L_8e205a:
	bl.d L_8c02bc
L_8e205e:
	mov_s r3,0x0
L_8e2060:
	sub_s sp,sp,0x10
L_8e2062:
	mov_s r14,r0
L_8e2064:
	mov_s r13,r1
L_8e2066:
	mov_s r16,r2
L_8e2068:
	mov_s r15,sp
L_8e206a:
	mov_s r0,r15
L_8e206c:
	ldb_s r1,[r14]
L_8e206e:
	mov_s r2,0x2
L_8e2070:
	mov r4,0x1
L_8e2074:
	mov r5,r4
L_8e2078:
	bl.d L_8c45c8
L_8e207c:
	mov r6,0x4
L_8e2080:
	mov.f r1,r13
L_8e2084:
	mov_s r0,sp
L_8e2086:
	mov.ne r1,0x1
L_8e208a:
	asl_s r1,r1
L_8e208c:
	bl.d L_8e848c
L_8e2090:
	cmp_s r13,0x0
L_8e2092:
	mov.ne r1,r16
L_8e2096:
	mov.eq r1,0x0
L_8e209a:
	bmsk_s r1,r1,0x1
L_8e209c:
	bl.d L_8e8438
L_8e20a0:
	mov_s r2,0x2
L_8e20a2:
	mov_s r0,r15
L_8e20a4:
	ldb_s r1,[r14]
L_8e20a6:
	mov_s r3,0x0
L_8e20a8:
	mov_s r4,r3
L_8e20aa:
	mov_s r5,r3
L_8e20ac:
	mov r6,0x1
L_8e20b0:
	bl.d L_8c46a4
L_8e20b4:
	mov r7,r6
L_8e20b8:
	b.d L_8c0324
L_8e20bc:
	add_s sp,sp,0x10
L_8e20be:
	nop_s
