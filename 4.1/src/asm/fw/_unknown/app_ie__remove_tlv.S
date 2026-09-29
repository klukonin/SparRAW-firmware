/* app_ie__remove_tlv @ 0x8de1a4, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Remove request Tlv type %d from block 0x%X.
 *   Tlv type %d has not been found.
 *   Tlv type %d found at 0x%X and removed, block size now is %d.
 * Зовут его: remove_app_ie
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit2, fw_log__emit3, ie_iter__init, ie_iter__next, memcpy_fw
 */
	.section .text.app_ie__remove_tlv,"ax",@progbits
	.global app_ie__remove_tlv
app_ie__remove_tlv:
	.global L_8de1a4
L_8de1a4:
	push_s blink
L_8de1a6:
	bl L_8c02bc
L_8de1aa:
	sub_s sp,sp,0xc
L_8de1ac:
	mov_s r13,r0
L_8de1ae:
	mov_s r14,r1
L_8de1b0:
	mov_s r2,0x100ef3c
L_8de1b6:
	ld r4,[r0]
L_8de1ba:
	mov_s r0,0xd
L_8de1bc:
	mov_s r1,0x2
L_8de1be:
	bl.d L_8edff8
L_8de1c2:
	mov_s r3,r14
L_8de1c4:
	mov_s r15,sp
L_8de1c6:
	mov_s r0,r15
L_8de1c8:
	bl.d L_8e112c
L_8de1cc:
	mov_s r1,r13
L_8de1ce:
	bl.d L_8db160
L_8de1d2:
	mov_s r0,r15
L_8de1d4:
	mov.f r16,r0
L_8de1d8:
	bne_s L_8de1ec
L_8de1da:
	b_s L_8de24a
	.global L_8de1dc
L_8de1dc:
	ldb r0,[r16]
L_8de1e0:
	brge r0,r14,L_8de1f2
L_8de1e4:
	bl.d L_8db160
L_8de1e8:
	mov_s r0,r15
L_8de1ea:
	mov_s r16,r0
	.global L_8de1ec
L_8de1ec:
	brne r16,0x0,L_8de1dc
L_8de1f0:
	b_s L_8de24a
	.global L_8de1f2
L_8de1f2:
	brge r14,r0,L_8de208
L_8de1f6:
	mov_s r2,0x100ef68
L_8de1fc:
	mov_s r0,0xd
L_8de1fe:
	mov_s r1,0x2
L_8de200:
	bl.d L_8edfcc
L_8de204:
	mov_s r3,r14
L_8de206:
	b_s L_8de24a
	.global L_8de208
L_8de208:
	ldb r15,[r16, 0x1]
L_8de20c:
	ld_s r0,[r13]
L_8de20e:
	/* add_s r15,0x2 */
	.byte 0x02,0xe7
L_8de210:
	extw_s r15,r15
L_8de212:
	ldw_s r2,[r13,0x4]
L_8de214:
	sub r1,r16,r0
L_8de218:
	sub_s r2,r2,r1
L_8de21a:
	sub_s r2,r2,r15
L_8de21c:
	extw_s r2,r2
L_8de21e:
	add r1,r16,r15
L_8de222:
	bl.d L_8c0460
L_8de226:
	mov_s r0,r16
L_8de228:
	ldw_s r0,[r13,0x4]
L_8de22a:
	mov_s r2,0x100ef88
L_8de230:
	sub r5,r0,r15
L_8de234:
	extw r5,r5
L_8de238:
	stw r5,[r13, 0x4]
L_8de23c:
	mov_s r0,0xd
L_8de23e:
	mov_s r1,0x2
L_8de240:
	mov_s r3,r14
L_8de242:
	bl.d L_8ee034
L_8de246:
	mov r4,r16
	.global L_8de24a
L_8de24a:
	b.d L_8c0324
L_8de24e:
	add_s sp,sp,0xc
