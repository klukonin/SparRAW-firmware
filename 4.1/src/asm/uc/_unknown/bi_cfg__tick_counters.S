/* bi_cfg__tick_counters @ 0x932e9c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow
 */
	.section .text.bi_cfg__tick_counters,"ax",@progbits
	.global bi_cfg__tick_counters
bi_cfg__tick_counters:
	.global L_932e9c
L_932e9c:
	push_s r13
L_932e9e:
	mov_s r2,0x80142c
L_932ea4:
	ldb_s r0,[r2]
L_932ea6:
	mov_s r3,0x801438
L_932eac:
	brne_s r0,0,L_932ec4
L_932eae:
	ldb_s r0,[r3,0x4]
L_932eb0:
	ldb_s r1,[r2,0x1]
L_932eb2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_932eb4:
	ldb_s r13,[r3,0x5]
L_932eb6:
	extb_s r1,r1
L_932eb8:
	stb_s r0,[r2]
L_932eba:
	stb_s r1,[r2,0x1]
L_932ebc:
	brne r1,r13,L_932ec4
L_932ec0:
	mov_s r1,0x0
L_932ec2:
	stb_s r1,[r2,0x1]
	.global L_932ec4
L_932ec4:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_932ec6:
	stb_s r0,[r2]
L_932ec8:
	ldb_s r0,[r3,0x8]
L_932eca:
	breq_s r0,0,L_932edc
L_932ecc:
	ldb_s r1,[r2,0x5]
L_932ece:
	cmp_s r1,0x0
L_932ed0:
	mov.ne r0,r1
L_932ed4:
	bne_s L_932ed8
L_932ed6:
	stb_s r0,[r2,0x5]
	.global L_932ed8
L_932ed8:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_932eda:
	stb_s r0,[r2,0x5]
	.global L_932edc
L_932edc:
	j_s.d [blink]
L_932ede:
	pop_s r13
