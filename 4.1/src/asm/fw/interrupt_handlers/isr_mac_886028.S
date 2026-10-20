/* isr_mac_886028 @ 0x8c0964, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwd_phy__rgf_883000_8cf4c8
 * Глобалы (через gp): 0x8002fc
 */
	.section .text.isr_mac_886028,"ax",@progbits
	.global isr_mac_886028
isr_mac_886028:
L_8c0964:
	push_s r12
L_8c0966:
	st.a mhi,[sp,-0x4]
L_8c096a:
	st.a mlo,[sp,-0x4]
L_8c096e:
	push_s r0
L_8c0970:
	push_s r1
L_8c0972:
	push_s r2
L_8c0974:
	push_s r3
L_8c0976:
	st.a r4,[sp,-0x4]
L_8c097a:
	st.a r5,[sp,-0x4]
L_8c097e:
	st.a r6,[sp,-0x4]
L_8c0982:
	st.a r7,[sp,-0x4]
L_8c0986:
	st.a r8,[sp,-0x4]
L_8c098a:
	st.a r9,[sp,-0x4]
L_8c098e:
	st.a r10,[sp,-0x4]
L_8c0992:
	st.a r11,[sp,-0x4]
L_8c0996:
	st.a lp_count,[sp,-0x4]
L_8c099a:
	lr r12,[0x2]
L_8c099e:
	push_s r12
L_8c09a0:
	lr r12,[0x3]
L_8c09a4:
	push_s r12
L_8c09a6:
	push_s blink
L_8c09a8:
	ld_s r0,[gp,0x18c]
L_8c09aa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c09ac:
	st.as r0,[gp,0x63]
L_8c09b0:
	bl.d L_8cf4c8
L_8c09b4:
	mov_s r0,0x0
L_8c09b6:
	mov_s r0,0x886e00
L_8c09bc:
	st 0x8000,[r0, 0x2c]
L_8c09c4:
	mov r1,-0x1
L_8c09c8:
	mov_s r0,0x886000
L_8c09ce:
	st_s r1,[r0,0x28]
L_8c09d0:
	pop_s blink
L_8c09d2:
	pop_s r12
L_8c09d4:
	sr r12,[0x3]
L_8c09d8:
	pop_s r12
L_8c09da:
	sr r12,[0x2]
L_8c09de:
	pop_s r12
L_8c09e0:
	mov_s lp_count,r12
L_8c09e2:
	ld.ab r11,[sp,0x4]
L_8c09e6:
	ld.ab r10,[sp,0x4]
L_8c09ea:
	ld.ab r9,[sp,0x4]
L_8c09ee:
	ld.ab r8,[sp,0x4]
L_8c09f2:
	ld.ab r7,[sp,0x4]
L_8c09f6:
	ld.ab r6,[sp,0x4]
L_8c09fa:
	ld.ab r5,[sp,0x4]
L_8c09fe:
	ld.ab r4,[sp,0x4]
L_8c0a02:
	pop_s r3
L_8c0a04:
	pop_s r2
L_8c0a06:
	pop_s r1
L_8c0a08:
	pop_s r0
L_8c0a0a:
	pop_s r12
L_8c0a0c:
	mulu64 r12,0x1
L_8c0a10:
	mov 0x0,mlo
L_8c0a14:
	pop_s r12
L_8c0a16:
	sr r12,[0x12]
L_8c0a1a:
	pop_s r12
L_8c0a1c:
	j.f [ilink1]
