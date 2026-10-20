/* uc_buffers__init @ 0x93800c, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_main_init
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, memset0_words_uc
 */
	.section .text.uc_buffers__init,"ax",@progbits
	.global uc_buffers__init
uc_buffers__init:
	.global L_93800c
L_93800c:
	push_s blink
L_93800e:
	bl.d L_92020c
L_938012:
	mov_s r3,0x18
L_938014:
	mov_s r0,0x855958
L_93801a:
	mov_s r14,0x855800
L_938020:
	st_s r0,[r14,0x50]
L_938022:
	mov_s r0,0x3c
L_938024:
	st_s r0,[r14,0x4c]
L_938026:
	mov_s r0,0x856498
L_93802c:
	st_s r0,[r14,0x60]
L_93802e:
	mov_s r0,0x24
L_938030:
	st_s r0,[r14,0x5c]
L_938032:
	mov_s r0,0x856918
L_938038:
	st_s r0,[r14,0x70]
L_93803a:
	st_s r3,[r14,0x6c]
L_93803c:
	mov_s r2,0x856d98
L_938042:
	mov_s r0,r2
L_938044:
	mov_s r1,0x855880
L_93804a:
	st_s r0,[r1]
L_93804c:
	mov_s r0,0x14
L_93804e:
	st_s r0,[r14,0x7c]
L_938050:
	add r0,r2,0x28
L_938054:
	st_s r0,[r1,0x10]
L_938056:
	st_s r3,[r1,0xc]
L_938058:
	mov_s r13,0x0
L_93805a:
	mov_s r15,0x5
	.global L_93805c
L_93805c:
	asl r16,r13,0x4
L_938060:
	add r0,r14,r16
L_938064:
	mov_s r1,0x800714
L_93806a:
	ldb_s r2,[r1,r13]
L_93806c:
	st_s r13,[r0,0x48]
L_93806e:
	st_s r2,[r0,0x54]
L_938070:
	ld_s r1,[r0,0x4c]
L_938072:
	add r16,r16,r14
L_938076:
	mulu64 r1,r2
L_93807a:
	mov_s r1,mlo
L_93807c:
	bl.d L_92166c
L_938080:
	ld_s r0,[r0,0x50]
L_938082:
	mov_s r0,0x855900
L_938088:
	sub r0,r0,0x100
L_93808c:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_93808e:
	ld r1,[r16, 0x50]
L_938092:
	add2_s r0,r0,r13
L_938094:
	st.as r1,[r0,0x4e]
L_938098:
	/* brhs.d r15,0x1,0x0093805c */
	.byte 0xc5,0x0f,0x75,0x90
L_93809c:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_93809e:
	.byte 0xd9,0x01
