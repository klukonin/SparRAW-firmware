/* uc_main_init @ 0x92160c, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_isr_memory_error__body
 * Зовёт сам: background_task__step, bi_mode_init_sequence, set_reg_88000c, set_reg_880010, uc_buffers__init, uc_irq_enable, uc_log__init, uc_send_evt__ucode_ready, uc_timers__start_defaults
 */
	.section .text.uc_main_init,"ax",@progbits
	.global uc_main_init
uc_main_init:
	.global L_92160c
L_92160c:
	push_s blink
L_92160e:
	bl L_937f68
L_921612:
	mov_s r2,0x4
L_921614:
	mov_s r1,0x800618
L_92161a:
	stw_s r2,[r1]
L_92161c:
	mov_s r0,0x1
L_92161e:
	stw_s r0,[r1,0x2]
L_921620:
	mov_s r0,0x0
L_921622:
	stw_s r0,[r1,0x4]
L_921624:
	mov r0,0x3e8
L_921628:
	st_s r0,[r1,0x8]
L_92162a:
	mov_s r0,0x37
L_92162c:
	stb_s r0,[r1,0xc]
L_92162e:
	mov_s r0,0x5
L_921630:
	stb_s r0,[r1,0xd]
L_921632:
	mov_s r0,0xc
L_921634:
	stb_s r0,[r1,0xe]
L_921636:
	mov_s r0,0xa
L_921638:
	stb_s r0,[r1,0xf]
L_92163a:
	stb_s r2,[r1,0x10]
L_92163c:
	mov_s r0,0x12
L_92163e:
	bl.d L_93800c
L_921642:
	stb_s r0,[r1,0x11]
L_921644:
	mov_s r0,0x800000
L_92164a:
	bl L_92792c
L_92164e:
	bl.d L_927938
L_921652:
	add_s r0,gp,0x34
L_921654:
	bl L_93171c
L_921658:
	bl L_936d88
L_92165c:
	bl L_925b5c
L_921660:
	bl L_9202d4
L_921664:
	bl L_921e14
L_921668:
	pop_s blink
L_92166a:
	j_s [blink]
