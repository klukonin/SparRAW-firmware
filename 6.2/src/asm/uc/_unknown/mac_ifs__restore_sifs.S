/* mac_ifs__restore_sifs @ 0x92bfc0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_kick
 * Глобалы (через gp): 0x8005be
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_ifs__restore_sifs
mac_ifs__restore_sifs:
	.global L_92bfc0
L_92bfc0:
	st.a r13,[sp,-0x4]
L_92bfc4:
	ldw.as r3,[gp,0x4b]
L_92bfc8:
	ldw r0,[0x802968]
L_92bfd0:
	breq.d r3,r0,L_92c000
L_92bfd4:
	mov r13,blink
L_92bfd8:
	stw.as r0,[gp,0x4b]
L_92bfdc:
	or r0,r0,0x1730000
L_92bfe4:
	st r0,[0x886d00]
L_92bfec:
	sync
L_92bff0:
	mov_s r1,0x38000200
L_92bff6:
	mov_s r32,r1
L_92bff8:
	st.ab r1,[r25,0x4]
L_92bffc:
	bclr r25,r25,0xa
	.global L_92c000
L_92c000:
	mov_s r2,0x3d000400
L_92c006:
	mov_s r32,r2
L_92c008:
	st.ab r2,[r25,0x4]
L_92c00c:
	bclr r25,r25,0xa
L_92c010:
	mov_s blink,r13
L_92c012:
	j_s.d [blink]
L_92c014:
	pop_s r13
L_92c016:
	nop_s
