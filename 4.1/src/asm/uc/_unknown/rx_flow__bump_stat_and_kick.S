/* rx_flow__bump_stat_and_kick @ 0x92f0ac, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: rx_flow__check_ppdu_and_ctx
 */
	.section .text.rx_flow__bump_stat_and_kick,"ax",@progbits
	.global rx_flow__bump_stat_and_kick
rx_flow__bump_stat_and_kick:
L_92f0ac:
	mov_s r1,r37
L_92f0ae:
	bbit0 r1,0x1,L_92f11c
L_92f0b2:
	ld r5,[0x801a78]
L_92f0ba:
	mov_s r0,0x8014f0
L_92f0c0:
	ld r1,[r5]
L_92f0c4:
	mov r6,0x20000400
L_92f0cc:
	add2 r0,r0,r1
L_92f0d0:
	ld.as r11,[r0,0x42]
L_92f0d4:
	add r11,r11,0x1
L_92f0d8:
	st.as r11,[r0,0x42]
L_92f0dc:
	mov r32,r6
L_92f0e0:
	st.ab r6,[r25,0x4]
L_92f0e4:
	bclr r25,r25,0xa
L_92f0e8:
	b L_92f10c
