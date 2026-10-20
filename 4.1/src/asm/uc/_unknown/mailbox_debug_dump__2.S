/* mailbox_debug_dump__2 @ 0x929f54, 368 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mailbox_debug_dump: m_ctrl->ring_tail_ptr - 0x%x, m_ctrl->ring_head_ptr - 0x%x
 *   mailbox_debug_dump: m_work_ptr - 0x%x, m_ring_base - 0x%x
 *   mailbox_debug_dump: sync entry
 *                      [0x%x]       [0x%x]
 * Зовут его: basic_if__post_to_fw_mailbox
 */
	.section .text.mailbox_debug_dump__2,"ax",@progbits
	.global mailbox_debug_dump__2
mailbox_debug_dump__2:
	.global L_929f54
L_929f54:
	ld_s r2,[r0,0xc]
L_929f56:
	mov r10,0x1001184
L_929f5e:
	mov r9,0x80209c
L_929f66:
	ldb r8,[r9, 0x4]
L_929f6a:
	ld_s r3,[r2,0x8]
L_929f6c:
	bbit0.d r8,0x0,L_929fbc
L_929f70:
	ld_s r2,[r2,0xc]
L_929f72:
	ld r4,[r9]
L_929f76:
	mov_s r1,0x8020b0
L_929f7c:
	add r11,r4,0x2
L_929f80:
	extb r11,r11
L_929f84:
	add2 r11,r1,r11
L_929f88:
	st r2,[r11]
L_929f8c:
	add r5,r4,0x1
L_929f90:
	extb r5,r5
L_929f94:
	add2 r5,r1,r5
L_929f98:
	st r3,[r5]
L_929f9c:
	bmsk r10,r10,0x13
L_929fa0:
	or r10,r10,0xa8000000
L_929fa8:
	extb r6,r4
L_929fac:
	add2 r1,r1,r6
L_929fb0:
	st r10,[r1]
L_929fb4:
	add r4,r4,0x3
L_929fb8:
	st r4,[r9]
	.global L_929fbc
L_929fbc:
	mov r5,0x10011d4
L_929fc4:
	ld r10,[r0]
L_929fc8:
	bbit0.d r8,0x0,L_92a01c
L_929fcc:
	ld_s r2,[r0,0x4]
L_929fce:
	ld r1,[r9]
L_929fd2:
	mov r11,0x8020b0
L_929fda:
	add r6,r1,0x2
L_929fde:
	add r7,r1,0x1
L_929fe2:
	extb r6,r6
L_929fe6:
	extb r7,r7
L_929fea:
	add2 r6,r11,r6
L_929fee:
	st r2,[r6]
L_929ff2:
	add2 r7,r11,r7
L_929ff6:
	st r10,[r7]
L_929ffa:
	extb r10,r1
L_929ffe:
	bmsk r5,r5,0x13
L_92a002:
	or r5,r5,0xa8000000
L_92a00a:
	add2 r10,r11,r10
L_92a00e:
	/* add_s r1,0x3 */
	.byte 0x03,0xe1
L_92a010:
	st r5,[r10]
L_92a014:
	st r1,[r9]
L_92a018:
	ld r2,[r0, 0x4]
	.global L_92a01c
L_92a01c:
	mov_s r3,0x1001210
L_92a022:
	bbit0 r8,0x0,L_92a050
L_92a026:
	bmsk_s r3,r3,0x13
L_92a028:
	ld r2,[r9]
L_92a02c:
	or r3,r3,0xa0000000
L_92a034:
	extb r4,r2
L_92a038:
	mov r11,0x8020b0
L_92a040:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_92a042:
	add2 r4,r11,r4
L_92a046:
	st r3,[r4]
L_92a04a:
	st r2,[r9]
L_92a04e:
	ld_s r2,[r0,0x4]
	.global L_92a050
L_92a050:
	ld_s r3,[r0,0x8]
L_92a052:
	cmp_s r2,r3
L_92a054:
	jcc [blink]
L_92a058:
	mov r10,0x1001230
	.global L_92a060
L_92a060:
	ld r6,[r2]
L_92a064:
	bbit0.d r8,0x0,L_92a0b8
L_92a068:
	ld r5,[r2, 0x4]
L_92a06c:
	ld r7,[r9]
L_92a070:
	mov r11,0x8020b0
L_92a078:
	add r4,r7,0x2
L_92a07c:
	add r1,r7,0x1
L_92a080:
	extb r4,r4
L_92a084:
	extb_s r1,r1
L_92a086:
	add2 r4,r11,r4
L_92a08a:
	st r5,[r4]
L_92a08e:
	add2 r1,r11,r1
L_92a092:
	st r6,[r1]
L_92a096:
	extb r3,r7
L_92a09a:
	bmsk r6,r10,0x13
L_92a09e:
	add2 r3,r11,r3
L_92a0a2:
	or r6,r6,0xa8000000
L_92a0aa:
	add r7,r7,0x3
L_92a0ae:
	st r6,[r3]
L_92a0b2:
	st r7,[r9]
L_92a0b6:
	ld_s r3,[r0,0x8]
	.global L_92a0b8
L_92a0b8:
	add_s r2,r2,0x8
L_92a0ba:
	cmp_s r2,r3
L_92a0bc:
	jcc [blink]
L_92a0c0:
	b_s L_92a060
L_92a0c2:
	nop_s
